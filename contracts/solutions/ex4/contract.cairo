%lang starknet

from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin, SignatureBuiltin
from starkware.starknet.common.syscalls import get_contract_address, get_caller_address
from starkware.starknet.common.messages import send_message_to_l1
from starkware.cairo.common.alloc import alloc

// l2 user address 361958816396474883452031563054282316433373339603650974221110346970974921578

@storage_var
func secret_var() -> (res: felt) {
}

@l1_handler
func my_function{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
     from_address: felt, rand_value: felt
) { 
    secret_var.write(rand_value);
    return ();
}

@view
func l1_assigned_var{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res:felt) {
    let res = secret_var.read();
    return (res);
}

// selector 1117096545982380049221663270575508921862375451831162369133862573542589356425

// Class hash 0x663ec4acaa9153fa92ebefecac8b00b2d2229a61e758088491c5243239f2299

// Address 0x07feda8741ef047ae0e864544df26baaa2f2ea67f3688cef5c50382ef4b0cbc2