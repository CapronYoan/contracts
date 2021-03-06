'user strict';

/**
 * @author Cyril Lapinte - <cyril.lapinte@openfiz.com>
 */

const assertRevert = require('../helpers/assertRevert');
const ProxyMock = artifacts.require('ProxyMock.sol');
const DelegateMock = artifacts.require('DelegateMock.sol');
const CoreMock = artifacts.require('CoreMock.sol');

contract('Proxy', function (accounts) {
  let core, delegate, proxy;

  it('should have static call successful', async function () {
    delegate = await DelegateMock.new();
    core = await CoreMock.new();
    proxy = await ProxyMock.new(core.address);

    await core.defineDelegateMock(1, delegate.address);
    await core.defineProxyMock(proxy.address, 1);

    const result = await proxy.delegateCallUint256Mock(42);
    assert.equal(result.toString(), '42', 'static value call');
  });

  describe('with accounts 0 as a core', function () {
    beforeEach(async function () {
      core = accounts[0];
      proxy = await ProxyMock.new(core);
    });

    it('Should have a core', async function () {
      const proxyCore = await proxy.core();
      assert.equal(core, proxyCore, 'core');
    });

    it('should let the core to success only core', async function () {
      const success = await proxy.successOnlyCore(true);
      assert.ok(success, 'success');
    });

    it('should prevent non core to success only core', async function () {
      await assertRevert(proxy.successOnlyCore(true, { from: accounts[1] }), 'PR01');
    });

    it('should let the core update proxy to a new core', async function () {
      const newCore = accounts[1];
      const success = await proxy.updateCore(newCore);
      assert.ok(success, 'success');

      const proxyCore = await proxy.core();
      assert.equal(newCore, proxyCore, 'core');
    });

    it('should prevent non core to update proxy to a new core', async function () {
      await assertRevert(proxy.updateCore(accounts[1], { from: accounts[1] }), 'PR01');
    });
  });
});
