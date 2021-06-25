pragma solidity 0.5.0;

import "./EthPriceOracleInterface.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract CallerContract is Ownable {
  EthPriceOracleInterface private oracleInstance;

  address private oracleAddress;
  uint256 private ethPrice;

  mapping(address => bool) myRequests;

  event newOracleAddressEvent(address oracleAddress);
  event ReceivedNewRequestIdEvent(uint256 id);
  event PriceUpdatedEvent(uint256 ethPrice, uint256 id);

  modifier onlyOracle() {
    require(msg.sender == oracleAddress, "You are not authorized to call this function.");
    _;
  }

  function setOracleInstanceAddress(address _oracleInstanceAddress) public onlyOwner {
    oracleAddress = _oracleInstanceAddress;
    oracleInstance = EthPriceOracleInterface(oracleAddress);

    emit newOracleAddressEvent(oracleAddress);
  }

  function updateEthPrice() public {
    uint256 id = oracleInstance.getLastestEthPrice();
    myRequests[id] = true;
    emit ReceivedNewRequestIdEvent(id);
  }

  function callback(uint256 _ethPrice, uint256 _id) public {
    require(myRequests[_id], "This request is not in my pending list.");
    ethPrice = _ethPrice;
    delete myRequests[_id];

    emit PriceUpdatedEvent(_ethPrice, _id);
  }
}
