const NFTDeployer = artifacts.require("NFTDeployer");

contract("NFTDeployer", (accounts) => {
    const account = accounts[0];
    console.log('TEST ACCOUNT : ' , account);
    let deployer;
    beforeEach(async() => {
        deployer = await NFTDeployer.deployed();
        console.log('NFT_DEPLOYER : ', deployer.address);
    })
    let nft_address;
    it('DEPLOY NEW NFT', async () => {
        nft_address = (await deployer.
            DeployNFT(
                "TEST_NFT",
                "TNT",
                "https://",
                { 
                    from: account
                }
            )
        ).receipt.logs[0].args.nft;

        console.log('NFT_ADDRESS : ', nft_address);
        assert.notEqual(nft_address,null,'address is null');
    })

    it('GET MY NFT', async () => {
        const call_address = (await deployer.getNFT(account));
        console.log('CALL_ADDRESS : ' ,call_address);
        assert.equal(nft_address,call_address[0],'address is not matched');
    })
})