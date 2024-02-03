// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Complain{
    struct ComplainDetails{
        string name;
        string complainAddress;
        string complain;
        string phone;
        string status;
        string report;
    }

    ComplainDetails [] public Complains;
    event EtherReceived(uint indexed amount);

    function getComplainIndex(string memory _phone) internal view returns (uint8) {
        for (uint8 i = 0; i < Complains.length; i++) {
            if (keccak256(abi.encodePacked(Complains[i].phone)) == keccak256(abi.encodePacked(_phone))) {
                return i;
            }
        }
        return 0;
    }

    function addComplains(string memory _name,string memory _address,string memory _complain,string memory phone) public {
        ComplainDetails storage newComplain = Complains.push();
        (newComplain.name,newComplain.complainAddress,newComplain.complain,newComplain.phone) = (_name,_address,_complain,phone);
    }

    function addStatus(string memory _status,string memory _phone) public {
        uint8 index = getComplainIndex(_phone); 
        ComplainDetails storage currentComplain = Complains[index];
        currentComplain.status = _status;
    }

    function addReport(string memory _report,string memory _phone) public {
        uint8 index = getComplainIndex(_phone);
        ComplainDetails storage currentComplain = Complains[index];
        currentComplain.report = _report;
    }

    function getPhoneComplaints()public view returns (ComplainDetails [] memory){
        return(Complains);
    }

    // Fallback function
    fallback() external payable {
        // Handle received Ether
        // You can add custom logic here
        emit EtherReceived(msg.value);
    }

    // Receive function
    receive() external payable {
        // Handle received Ether
        // You can add custom logic here
        emit EtherReceived(msg.value);
    }

}