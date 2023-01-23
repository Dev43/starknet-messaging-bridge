if [ "$1" == "deploy" ]; then 
    echo "deploying..."
    starknet deploy  --network alpha-goerli --class_hash $2
elif [ "$1" == "declare" ]; then 
    echo "declaring..."
    starknet declare --contract  ./contract_compiled.json --network alpha-goerli 
else 
    echo "compiling..."
    starknet-compile ./contract.cairo --output ./contract_compiled.json
fi

# Class hash 0xabd7b2a5ec65ee579c000c9c427be654278c136a10f82100f386ff68d96ac3

# Address: 0x007f23e156eee718b6417d5d8a27c265345370d4c4eab1241c5b24b30cc8a7ce