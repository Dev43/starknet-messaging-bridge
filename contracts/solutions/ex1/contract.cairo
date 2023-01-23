%lang starknet

from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.starknet.common.syscalls import get_contract_address, get_caller_address
from starkware.starknet.common.messages import send_message_to_l1
from starkware.cairo.common.alloc import alloc
// L1 Messaging NFT 0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E

// need to call function createNftFromL2(uint256 l2_user, uint256 playerL2Contract) public

const L1_CONTRACT_ADDRESS = (0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E);

// L2 contract address 51145025645046311584619977709158611580605765565482223741227143191424464926
// l2 user address 361958816396474883452031563054282316433373339603650974221110346970974921578

@external
func create_l1_nft_message{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    l1_user: felt
) {
    let (message_payload: felt*) = alloc();
    assert message_payload[0] = l1_user;
    send_message_to_l1(to_address=L1_CONTRACT_ADDRESS, payload_size=1, payload=message_payload);

    return ();
}
