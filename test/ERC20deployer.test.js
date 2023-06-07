const ERC20Deployer = artifacts.require("ERC20Deployer");
const ERC20Template = artifacts.require("ERC20Template");

contract("ERC20Deployer", (accounts) => {
    const account = accounts[0];
    console.log('TEST ACCOUNT : ' , account);
    let deployer;
    beforeEach(async() => {
        deployer = await ERC20Deployer.deployed();
        console.log('ERC20_DEPLOYER : ', deployer.address);
    })
    let erc20_address;
    it('DEPLOY NEW ERC20', async () => {
        erc20_address = (await deployer.
            DeployERC20(
                "TEST_TOKEN",
                "TTK",
                "100000000000000000000000000",
                { 
                    from: account
                }
            )
        ).receipt.logs[0].args.token;

        console.log('ERC20_ADDRESS : ', erc20_address);
        assert.notEqual(erc20_address,null,'address is null');
    })

    it('GET MY ERC20', async () => {
        const call_address = (await deployer.getERC20(account));
        console.log('CALL_ADDRESS : ' ,call_address);
        assert.equal(erc20_address,call_address[0],'address is not matched');
    })

    it('CHECK ERC20 OWNER BALANCE' , async () => {
        const erc20_instance = new ERC20Template(erc20_address);
        const balance = await erc20_instance.balanceOf(account);
        const test = (await erc20_instance.balanceOf(deployer.address)).toString()
        console.log('balance : ' ,test);
        assert.equal("100000000000000000000000000",balance.toString(),'balance not matched');
    })
})