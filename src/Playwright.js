/* global exports */

export const launchImpl = browser => options => () => browser.launch()

export const closeImpl = browser => () => browser.close()

export const contextsImpl = browser => () => browser.contexts()

export const isConnectedImpl = browser => () => browser.isConnected()

export const versionImpl = browser => () => browser.version()

export const newPageImpl = browser => options => () => browser.newPage()

export const goForwardImpl = page => options => () => page.goForward(options)

export const goBackImpl = page => options => () => page.goBack(options)

export const gotoImpl = page => url => options => () => page.goto(url, options)

export const addCookiesImpl = browserContext => cookies => () => browserContext.addCookies(cookies)

export const hoverImpl = page => options => () => page.hover(options)

export const innerHTMLImpl = page => selector => options => () => page.innerHTML(selector, options)

export const innerTextImpl = page => selector => options => () => page.innerText(selector, options)

export const isClosedImpl = page => () => page.isClosed()

export const keyboardImpl = page => () => page.keyboard

export const mainFrameImpl = page => () => page.mainFrame()

export const nameImpl = frame => () => frame.name()

export const queryImpl = page => selector => () => page.query(selector)

export const queryManyImpl = page => selector => () => page.queryMany(selector)

export const screenshotImpl = page => options => () => page.screenshot(options)

export const textContentImpl = page => selector => () => page.textContent(selector)

export const urlImpl = page => () => page.url()

export const addInitScriptImpl = page => options => () => page.addInitScript(options)

export const clearCookiesImpl = browserContext => () => browserContext.clearCookiesImpl()

export const clickImpl = page => selector => options => () => page.click(selector, options)

export const contentImpl = page => () => page.content()

export const dblclickImpl = page => selector => options => () => page.dblclick(selector, options)

export const evaluateImpl = page => method => () => page.evaluate(method)

export const evaluateHandleImpl = page => method => () => page.evaluateHandle(method)

export const waitForNavigationImpl = page => options => () => page.waitForNavigation(options)

export const waitForRequestImpl = page => url => options => () => page.waitForRequest(url, options)

export const waitForResponseImpl = page => url => options => () => page.waitForResponse(url, options)

export const waitForSelectorImpl = page => selector => options => () => page.waitForSelector(selector, options)

export const waitForFunctionImpl = page => method => options => () => page.waitForFunction(method, undefined, options)

export const waitForLoadStateImpl = page => state => options => () => page.waitForLoadState(state, options)

export const waitForTimeoutImpl = page => timeout => () => page.waitForTimeout(timeout)

export const pdfImpl = page => options => () => page.pdf(options)

export const setInputFilesImpl = page => selector => files => options => () => page.setInputFiles(selector, files, options)

export const setViewportSizeImpl = page => size => () => page.setViewportSizeImpl(size)

export const titleImpl = page => () => page.title()

export const exposeBinding_ = x => name => cb => opts => () => {
  return x.exposeBinding(
    name,
    function (info, arg) {
      return cb(info)(arg)()
    },
    opts
  )
}
