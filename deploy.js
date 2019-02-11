const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const {interface, bytecode} = require('./compile');

const provider = new HDWalletProvider(
    'taxi bulk possible fringe elevator someone jealous romance estate suit object speed',
    'https://rinkeby.infura.io/v3/b6e31ebddb3d4616aed7fc5878402607'
);

const web3 = new Web3(provider);

const deploy = async () =>{
    const accounts = await web3.eth.getAccounts();
    console.log('account', accounts[0]);
    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({data: '0x' + bytecode})
        .send({from: accounts[0]});

    console.log('contract deployed to', result.options.address);
};

deploy(); 