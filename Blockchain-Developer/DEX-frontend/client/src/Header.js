import React from 'react';
import Dropdown from './Dropdown.js';

function Header({
  user,
  tokens,
  contracts,
}) {
  return (
    <header id="header" className="card">
      <div className="row">
        <div className="col-sm-3 flex">
          <Dropdown 
            items={tokens.map(token => ({
              label: token.ticker,
              value: token
            }))}
            activeItem={{
              label: user.selectedToken.ticker,
              value: user.selectedToken
            }}
            onSelect={selectToken}
          />
        </div>
      </div>
    </header>
  )
}
