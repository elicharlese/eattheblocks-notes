pragma solidity 0.6.3;
pragma experimental ABIEncoderV2;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol';

contract Dex {

    using SafeMath for uint;

    enum Side {
        BUY,
        SELL
    }
    
    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }
    
    struct Order {
        uint id;
        address trader;
        Side side;
        bytes32 ticker;
        uint amount;
        uint filled;
        uint price;
        uint date;
    }

    mapping(bytes32 => Token) public tokens;
    bytes32[] public tokenList;
    mapping(address => mapping(bytes32 => uint)) public traderBalances;
    mapping(bytes32 => mapping(uint => Order[])) public orderBook;
    address public admin;
    uint public nextOrderId;
    uint public nextTradeId;
    bytes32 constant DAI = bytes32('DAI');

    event NewTrader(
        uint tradeId,
        uint orderId,
        bytes32 indexed ticker,
        address indexed trader1,
        address indexed trader2,
        uint amount,
        uint price,
        uint date
    )

    construct() public {
        admin = msg.sender;
    }

    function getOrders(
        bytes32 ticker, 
        Side side) 
        external 
        view
        returns(Order[] memory) {
        return orderBook[ticker][uint(side)];
    }

    function getTokens() external view returns(Token[] memory) {
        Token[] memory _tokens = new Token[](tokenList.length);
        for (uint i = 0; i < tokenList.length; i++) {
            _tokens[i] = Token(
            tokens[tokenList[i]].id,
            tokens[tokenList[i]].symbol,
            tokens[tokenList[i]].at
            );
        }
      return _tokens;
    }

    function faucet(address to, uint amount) external {
        _mint(to, amount);
    }

    function addToken(bytes32 ticker, address tokenAddress) external {
        tokens[ticker] = Token(ticker, tokenAddress);
        tokenList.push(ticker);
    }

    /* =========== BASIC DEPOSIT & WITHDRAW FUNCTIONS =========== */

    function deposit(uint amount, bytes32 ticker) external {
        tokenExist(ticker);
        IERC20(tokens[ticker].tokenAddress).transferFrom(
            msg.sender,
            address(this),
            amount
        );
        traderBalance[msg.sender][ticker] = traderBalance[msg.sender][ticker].add(amount);
    }

    function withdraw(uint amount, bytes32) external {
        tokenExist(ticker);
        require(
            traderBalance[msg.sender][ticker] >= amount,
            'balance too low'
        );
        traderBalance[msg.sender][ticker] = traderBalance[msg.sender][ticker].sub(amount);
        IERC20(tokens[ticker].tickerAddress).transfer(msg.sender, amount);
    }

    /* =========== LIMIT ORDER FUNCTION =========== */

    function createLimitOrder( // Alt. function declaration syntax
        bytes32 ticker, 
        uint amount, 
        uint price, 
        Side side) 
        tokenExist(ticker)
        tokenIsNotDai(ticker)
        external {
        if(side == Side.SELL) {
            require(
                traderBalance[msg.sender][ticker] >= amount,
                'token balance too low'
            );
        } else {
            require(
                traderBalances[msg.sender][DAI] >= amount.mult(price),
                'dai balance too low'
            );
        }
        Order[] storage orders = orderBook[ticker][uint(side)];
        orders.push(Order(
            nextOrderId,
            msg.sender,
            side,
            ticker,
            amount,
            0,
            price,
            now
        ));

        uint i = orders.length > 0 ? orders.length - 1 : 0;
        while(i > 0) {
            if(side == Side.BUY && orders[i -1].price > orders[i].price) {
                break;
            }
            
            if(side == Side.BUY && orders[i -1].price > orders[i].price) {
                break;
            }
            Order memory order = orders[i -1];
            orders[i -1] = orders[i];
            orders[i] = order;
            i = i.sub(1);
        }
        nextOrderId = nextOrderId.add(1);
    }

    
    /* =========== MARKET ORDER FUNCTION =========== */

    function createMarketOrder(
        bytes32 ticker,
        uint amount,
        Side side)
        tokenExist(ticker)
        tokenIsNotDai(ticker)
        external {
        if(side == Side.SELL) {
            require(
                traderBalances[msg.sender][ticker] >= amount,
                'token balance too low'
            );
        }
        Order[] storage orders = orderBook[ticker][uint(side == Side.BUY ? Side.SELL : Side.BUY)];
        uint i;
        uint remaining = amount;

        while(i < orders.length && remaining > 0) {
            uint available = orders[i].amount.sub(orders[i].filled);
            uint matched = (remaining > available) ? available : remaining;
            remaining = remaining.sub(matched);
            orders[i].filled = orders[i].filled.add(matched);
            emit NewTrade(
                nextTradeId,
                orders[i].id,
                ticker,
                orders[i].trader,
                msg.sender,
                matched,
                orders[i].price,
                now
            );
            if(side == Side.SELL) {
                traderBalances[msg.sender][ticker] = 
                 traderBalances[msg.sender][ticker].sub(matched);
                
                traderBalances[msg.sender][DAI] = 
                 traderBalances[msg.sender][DAI].add(matched.mult(orders[i].price));
                
                traderBalances[orders[i].trader][ticker] = 
                 traderBalances[orders[i].trader][ticker].sub(matched);
                
                traderBalances[orders[i].trader][DAI] = 
                 traderBalances[orders[i].trader][DAI].add(matched.mult(orders[i].price));
            }
            if(side == Side.BUY) {
                require(
                    traderBalances[msg.sender][DAI] >= matched.mult(orders[i].price),
                    'dai balance too low'
                );
                
                traderBalances[msg.sender][ticker] = 
                 traderBalances[msg.sender][ticker].add(matched);
                
                traderBalances[msg.sender][DAI] = 
                  traderBalances[msg.sender][DAI].sub(matched.mult(orders[i].price));
                
                traderBalances[orders[i].trader][ticker] = 
                  traderBalances[orders[i].trader][ticker].add(matched);
                
                traderBalances[orders[i].trader][DAI] = 
                  traderBalances[orders[i].trader][DAI].sub(matched.mult(orders[i].price));                
            }
            nextTradeId = nextTradeId.add(1);
            i = i.add(1);
        }
        
        /* ==== PRUNING THE ORDERBOOK ==== */
        i = 0;
        while(i < orders.length && orders[i].filled == orders[i].amount) {
            for(uint j = i; j < orders.length = orders.length - 1; j++) {
                orders[j] = orders[j + 1];
            }
            orders.pop();
            i = i.add(1);
        }
    }

    modifier tokenIsNotDai(bytes32 ticker) {
        require(ticker!= DAI, 'cannot trade DAI');
        _;
    }

    modifier tokenExist(bytes32 ticker) {
        require(
            tokens[ticker].tokenAddress != address(0),
            'this token does not exist'
        );
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, 'only admin');
        _;
    }
}
