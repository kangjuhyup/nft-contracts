const ERC20Deployer = artifacts.require("ERC20Deployer");
const fs = require('fs');
contract("ERC20Deployer", (accounts) => {
    const account = accounts[0];
    console.log('TEST ACCOUNT : ' , account);
    let deployer;
    beforeEach(async() => {
        deployer = await ERC20Deployer.deployed();
        console.log('ERC20_DEPLOYER : ' ,deployer.address)
    })
    let erc20_address;
    it('DEPLOY ERC20', async () => {
        const bytecode = `0x`+fs.readFileSync('/Users/kangjuhyup/Documents/nft-contracts/bin/contracts/ERC20Template.bin').toString();
        erc20_address = (await deployer.
            deployERC20(
                bytecode,
                "test",
                "test",
                "100000000000000000000000000",
                { 
                    from: account,
                }
            )
        ).receipt.logs[0].args.erc20;

        console.log('ERC20_ADDRESS : ', erc20_address);
        assert.notEqual(erc20_address,'0x0000000000000000000000000000000000000000','address is null');
    })
    
})