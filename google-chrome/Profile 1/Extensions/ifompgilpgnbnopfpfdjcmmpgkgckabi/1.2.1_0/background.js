(()=>{"use strict";({985:function(){var e=this&&this.__awaiter||function(e,t,n,o){return new(n||(n=Promise))((function(i,r){function c(e){try{d(o.next(e))}catch(e){r(e)}}function s(e){try{d(o.throw(e))}catch(e){r(e)}}function d(e){var t;e.done?i(e.value):(t=e.value,t instanceof n?t:new n((function(e){e(t)}))).then(c,s)}d((o=o.apply(e,t||[])).next())}))};chrome.runtime.onInstalled.addListener((()=>{chrome.contextMenus.removeAll((()=>{chrome.contextMenus.create({id:"fontIdentifierContextMenu",title:chrome.i18n.getMessage("appName"),contexts:["all"]})}))}));const t=t=>e(void 0,void 0,void 0,(function*(){try{yield chrome.scripting.executeScript({target:{tabId:t},files:["content.js"]}),chrome.tabs.sendMessage(t,{})}catch(e){console.log(e)}}));chrome.contextMenus.onClicked.addListener(((e,n)=>{(null==n?void 0:n.id)&&t(n.id)})),chrome.commands.onCommand.addListener((e=>{chrome.tabs.query({active:!0,currentWindow:!0},(function(e){const n=e[0];(null==n?void 0:n.id)&&t(n.id)}))})),chrome.runtime.onMessage.addListener(((e,t,n)=>{if("openWindow"===e.command){const t={width:500,height:650};let n=e.blockStyle;chrome.windows.getCurrent((o=>{if(o&&void 0!==o.left&&void 0!==o.top&&void 0!==o.width&&void 0!==o.height){e.id=o.id;const i=o.left+Math.round((o.width-500)/2);let r=Object.keys(n).map((e=>e+"="+n[e])).join("&");chrome.windows.create({url:chrome.runtime.getURL("data/index.html?"+r),type:"panel",left:i,width:Math.max(t.width,200),height:Math.max(t.height,200)},(e=>{}))}else console.log("Window properties are undefined")}))}"setHeight"===e.action&&e.height&&chrome.windows.getCurrent((t=>{null!=t.id?chrome.windows.update(t.id,{height:e.height+40}):console.log("Window properties are undefined")}))})),chrome.runtime.onInstalled.addListener((e=>{if(e.reason===chrome.runtime.OnInstalledReason.INSTALL){chrome.tabs.create({url:"https://font-identifier.tilda.ws/welcome"});const e=(new Date).toISOString();chrome.storage.sync.set({installDate:e})}else e.reason===chrome.runtime.OnInstalledReason.UPDATE||e.reason===chrome.runtime.OnInstalledReason.CHROME_UPDATE||(e.reason,chrome.runtime.OnInstalledReason.SHARED_MODULE_UPDATE)})),chrome.action.onClicked.addListener((e=>{e.id&&t(e.id)})),chrome.runtime.setUninstallURL("https://docs.google.com/forms/d/e/1FAIpQLSei5z2LwBPZnd1eMjPpTR-kwJALracOgayE1--hfjo249Y2KA/viewform?usp=sf_link")}})[985]()})();