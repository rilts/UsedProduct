pragma solidity ^0.4.19;

contract UsedProduct {

    event NewlyEnrollProduct(string productName, uint price);

    struct Product {
        uint price;
        string productName;
        address pOwner;
        address buyer;
    }

    Product [] public productList;
    mapping (address => uint) public enrollCount;
    mapping (address => uint) public buyCount;
    mapping (address => string) nickName;

    function enrollProduct(string _pName, uint _price) public {
        uint id = productList.push(Product(_price, _pName, msg.sender, 0));
        enrollCount[msg.sender]++;
        emit NewlyEnrollProduct(_pName, _price);
    }
    function buy(uint productIndex) payable public {
        Product prod = productList[productIndex];
        prod.buyer = msg.sender;
        
        if (!prod.pOwner.send(msg.value)) {
            revert();
        }
    }
    function getSize() public returns(uint){
        return productList.length;
    }

    function enrollNickName(string _nick) public {
        nickName[msg.sender] = _nick;
    }

    function getNickName() public view returns(string) {
        return nickName[msg.sender];
    }
    /*
    function getProductList() public returns(Product [] ) {
        return productList;
    }
    function getProductList() public returns(bytes) {
        bytes memory pList;
        for(uint i=0; i<productList.length; i++) {
            pList += productToBytes(productList[i]);
        }
        return pList;
    }
    function productToBytes(Product u) private returns (bytes data) {
        uint _size = 44 + bytes(u.productName).length;
        bytes memory _data = new bytes(_size);

        uint counter=0;
        for (uint i=0;i<4;i++) {
            _data[counter]=byte(u.price>>(8*i)&uint32(255));
            counter++;
        }

        for (i=0;i<bytes(u.productName).length;i++) {
            _data[counter]=bytes(u.productName)[i];
            counter++;
        }
        for (i = 0; i < 20; i++) {
            _data[counter] = byte(uint8(uint(u.pOwner) / (2**(8*(19 - i)))));
            counter++;
        }
        for (i = 0; i < 20; i++) {
            _data[counter] = byte(uint8(uint(u.buyer) / (2**(8*(19 - i)))));
            counter++;
        }

        return (_data);
    }
    function getProductList() public returns(bytes) {
        uint _size = 0;
        uint _tLen = 0;
        uint count=0;
        mapping (uint => uint) _pSize;
        for(uint i=0; i<productList.length; i++) {
            _tLen = 44 + bytes(productList[i].productName).length;
            _size += _tLen;
            _pSize[count] = _tLen;
        }
        bytes memory pList = new bytes(_size);
        count=0;
        uint _binx = 0;
        for(i=0; i<productList.length; i++) {
            pList[_binx] += productToBytes(productList[i]);
            _binx += _pSize[count];
            count++;
        }
        return pList;
    }
    function productToBytes(Product u) private returns (bytes data) {
        uint _size = 44 + bytes(u.productName).length;
        bytes memory _data = new bytes(_size);

        uint counter=0;
        for (uint i=0;i<4;i++) {
            _data[counter]=byte(u.price>>(8*i)&uint32(255));
            counter++;
        }

        for (i=0;i<bytes(u.productName).length;i++) {
            _data[counter]=bytes(u.productName)[i];
            counter++;
        }
        for (i = 0; i < 20; i++) {
            _data[counter] = byte(uint8(uint(u.pOwner) / (2**(8*(19 - i)))));
            counter++;
        }
        for (i = 0; i < 20; i++) {
            _data[counter] = byte(uint8(uint(u.buyer) / (2**(8*(19 - i)))));
            counter++;
        }

        return (_data);
    }
    */
}
