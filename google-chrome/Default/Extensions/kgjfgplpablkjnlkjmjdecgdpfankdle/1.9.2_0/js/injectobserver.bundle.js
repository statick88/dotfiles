!function(){if(window.XMLHttpRequest){var e=window.XMLHttpRequest;window.XMLHttpRequest=function(){var t,n=new e;let o="",r=document.querySelector("#zoom-quick2adv-number");r&&null!==r&&(o=r.textContent);let i=w("#zoom-whiteboard-record"),a=w("#zoom-workspace-save-data"),s="",l="",c="https://calendar.google.com";function d(e,t){if("string"==typeof e){let n=function(e){for(var t={},n=e.split("&"),o=0;o<n.length;o++){var r=n[o].split("=");t[decodeURIComponent(r[0])]=decodeURIComponent(r[1])}return t}(e);if(void 0!==n[t])return n[t]}return null}function u(e){var t=null;try{e=(e=e.replace(/\n/g," ")).substring(e.indexOf("'")+1,e.length),t=JSON.parse(e)}catch(e){}return t}function f(e){let t=null,n=null,o="";try{let r=e;o=r[5];let i=r[35][1][0],a=r[36][1][0],s=JSON.parse(document.querySelector("#timezonedata").innerText)[0];n=r[35][2],n||(n=document.querySelector("#xTimezone").innerText);let l=0;for(let e=0,t=s.length;e<t;e++){let t=s[e];if(t[0]===n){l=36e5*parseInt(t[1].slice(4,7));let e=6e4*parseInt(t[1].slice(8,10));e>0&&(l=l>0?l+e:l-e);break}}i=new Date(i+l).toJSON().split(".000Z")[0].replace(/-/g,"").replace(/:/g,""),a=new Date(a+l).toJSON().split(".000Z")[0].replace(/-/g,"").replace(/:/g,""),t=i+"/"+a}catch(e){console.log("Dates conversion failed: "+e)}return{dates:t,timezone:n,topic:o}}function m(){let e=document.querySelector("#zoom_repeat_edit_flag"),t=null;return e&&(t=e.textContent,e.textContent="0"),t}function p(e){let t=function(){let e=document.querySelector("#zoom_recurring_edit_flag")?.textContent;return e||l?e!==l?e||l:e:""}();if("ALL"===t||"TAIL"===t){if(e.indexOf("_R")>-1)try{let{sourceId:t,date:n}=v(s),{sourceId:o,date:r}=v(e);if(t&&n&&r&&t===o&&n>=r)return!0}catch(e){}}else if(s===e)return!0;return!1}function y(){let e=function(){let e,t=document.querySelector("#zoom_recurring_edit_flag");return t&&(e=t.textContent,t.textContent=""),e}();return!g(s)||"ALL"===e||"TAIL"===e||"ALL"===l||"TAIL"===l||void 0}function g(e){return!!e&&new RegExp("^\\w{10,}(_[A-Za-z]?\\d{8}[A-Za-z]\\d{6}[A-Za-z]?)$","").test(e)}function h(e){return e?e.replace(/_[A-Za-z]?\d{8}[A-Za-z]\d{6}[A-Za-z]?/g,""):""}function v(e){if(e){let t=new RegExp("^(\\w{10,})_[A-Za-z]?(\\d{8})[A-Za-z]\\d{6}[A-Za-z]?$","").exec(e);if(t&&t.length)return{sourceId:t[1],date:t[2]}}return{sourceId:"",date:""}}function w(e){let t=null,n=document.querySelector(e)?.textContent;if(n)try{t=JSON.parse(n)}catch(e){}return t}var x=n.open;function z(e){if(Array.isArray(e)){let t=e[0];if(Array.isArray(t)&&t.length)for(let e=t.length-1;e>-1;e--){let n=t[e];if(Array.isArray(n)){let e=n[0];if(e&&e.length>10)return s=e,l=Array.isArray(n[2])?"TAIL":1===n[1]?"ALL":"",!0}}}return!1}function C(){let e=a?.workspaceRooms;s&&Array.isArray(e)&&window.postMessage({event_baseid:s,workspaceRooms:e,action:"cacheWorkspaceRooms"},c)}n.open=function(e,n,r){return this._path=n,this.addEventListener("readystatechange",(function(){if(4===this.readyState){var e=d(t,"action");if("event"===n&&"CREATE"===e){var r=u(this.responseText),l="";if((w=document.querySelector("#zoom-quick2adv-number"))&&null!==w&&(l=w.textContent),r&&void 0!==r[0]&&void 0!==r[0][1]&&""!==l){let e=r[7][1];"string"==typeof e&&e.length>20&&window.postMessage({calendarId:e,action:"event",number:l},c),document.querySelector("#zoom-quick2adv-number").textContent=""}}else if("deleteevent"===n){var v=d(t,"eid");v&&v.length<128&&window.postMessage({calendarId:v,action:"deleteevent"},c)}else if("event"===n&&"EDIT"===e){var w;(w=document.querySelector("#zoom-quick2adv-number"))&&w.textContent&&(w.textContent="");let e=d(t,"eid"),n=d(t,"dates"),o=document.querySelector("#zoom_edit_event_flag").textContent;if(document.querySelector("#zoom_edit_event_flag").textContent="0","0"===o&&e&&n){let t=null;try{let e=u(this.responseText);t=JSON.parse(e[0][1])[22][3][0]}catch(e){}window.postMessage({calendarId:e,action:"updatetimeandtimezone",dates:n,timezone:t},c)}}else{if("sync.sync"!==n)return;{let e=null;try{e=JSON.parse(d(t,"f.req"))}catch(e){}let n=u(this.responseText),r=null,l=null,v=null,w=null,z=null,C=null,q=null,A=null,b=null;try{q=n[0][2][3]}catch(e){}try{l=n[0][2][11][2],A=atob(l)}catch(e){}if(Array.isArray(q)&&(A||s)){let e,t=g(s),n=t&&h(s)||"";for(let o=q.length-1;o>-1;o--){let r=q[o];if(Array.isArray(r)){let o=r[1];if(Array.isArray(o)&&o.length){for(let r=o.length-1;r>-1;r--){let i=o[r];if(Array.isArray(i)){let o=i[3];if(Array.isArray(o)&&o[0]){let r=o[0];if(t){if(p(r)){z=o;break}r===n&&(e=o)}else if(A&&A.indexOf(r)>-1||!A&&r===s){z=o;break}}}}!z&&e&&(z=e)}}if(z){C=r[0];break}}}if(Array.isArray(z)&&(r=z[2],v=z[1],w=z[0],b=z[34]?.[0]||""),r){let e=r.split("eid=")[1],t=!1,n=null,l=null,d=null,u=[];if(w){let e=z[20];if(Array.isArray(e)){d=[];for(var x=0;x<e.length;x++)try{let t=e[x][0],n=e[x][1];t&&d.push(t),n&&u.push(n)}catch(e){}}}if(A&&w){let r="";try{r=A.split(w)[1]}catch(e){console.log("Markup field format changes!")}if(r.length<6){let t="",r=document.querySelector("#zoom-quick2adv-number");o?t=o:r&&(t=r.textContent);let d="",p=document.querySelector("#zoom-whiteboard-record");if(i)d=i;else if(p)try{d=JSON.parse(p.textContent)}catch(e){}if(e&&(t||d)){if("string"==typeof e&&e.length>20){let o={calendarId:e,action:"event",number:t||"",event_baseid:w};d?.docId&&(o.scheduleTime=d.scheduleTime||"",o.wb_doc_id=d.docId,o.wb_permission=d.permission),window.postMessage(o,c),t&&(n=t),d&&(l=d)}if(r&&o==r.textContent&&(r.textContent=""),p&&i)try{let e=JSON.parse(p.textContent);i.docId==e.docId&&i.permission==e.permission&&(p.textContent="")}catch(e){}if("1"===m()||u.length){let{dates:e,timezone:n,topic:o}=f(z);e&&window.postMessage({event_baseid:w,action:"updatetimeandtimezone",dates:e,timezone:n,topic:o,number:t,eventOwner:b,zoomrooms:u.join(",")},c)}}!function(e,t){let n=null,o=document.querySelector("#zoom-workspace-save-data");if(a?.workspaceInfo)n=a;else if(o)try{n=JSON.parse(o.textContent)}catch(e){}if(e&&n?.workspaceInfo&&"string"==typeof e&&e.length>20&&(window.postMessage({event_baseid:t,workspaceData:n,action:"saveWorkspace"},c),o&&o.textContent))try{JSON.parse(o.textContent).workspaceInfo[0].workspaceIds.join("")===n.workspaceInfo[0].workspaceIds.join("")&&(o.textContent="")}catch(e){}}(e,w),s?(s!=w&&(console.log("The create request occurs, but sendBaseid is not equal to nid!"),window.postMessage({event_baseid:w,action:"recordZmlog",msgType:7,msg:{msg:"The create request occurs, but sendBaseid is not equal to nid!",nid:w,sendBaseid:s,filename:"zm-observer.js"},operaType:3},c)),s=""):(console.log("The create request occurs, but sendBaseid has no value!"),window.postMessage({event_baseid:w,action:"recordZmlog",msgType:7,msg:{msg:"The create request occurs, but sendBaseid has no value!",nid:w,filename:"zm-observer.js"},operaType:3},c))}else{let n=document.querySelector("#zoom-quick2adv-number");n&&n.textContent&&(n.textContent="");let r=document.querySelector("#zoom-whiteboard-record");r&&r.textContent&&(r.textContent="");let i=document.querySelector("#zoom_edit_event_flag"),a=null;i&&(a=i.textContent,i.textContent="0");let s="1"===m();if(("0"===a||s||u.length)&&e){let{dates:e,timezone:n,topic:r}=f(z);e&&(window.postMessage({event_baseid:w,action:"updatetimeandtimezone",dates:e,timezone:n,topic:r,number:s?o:"",eventOwner:b,zoomrooms:u.join(",")},c),"0"===a&&(t=!0))}}}else if(w){if("1"===m()||u.length){let{dates:e,timezone:t,topic:n}=f(z);e&&window.postMessage({event_baseid:w,action:"updatetimeandtimezone",dates:e,timezone:t,topic:n,number:o,eventOwner:b,zoomrooms:u.join(",")},c)}let e=document.querySelector("#zoom-quick2adv-number");e&&e.textContent&&(e.textContent="");let t=document.querySelector("#zoom_edit_event_flag");t&&(t.textContent="0")}if(w&&!t&&Array.isArray(d)&&y()){let e=w;if("string"==typeof w&&w.indexOf("_")>-1&&(e=h(w)),n||l)d.length&&window.postMessage({meetingNumber:n,wb_doc_id:l?.docId,wb_permission:l?.permission,event_baseid:e,action:"saveInvitee",invitee:d,eventOwner:b,reFilter:!1},c);else{let t,n=z[7];try{t=z[64][1]}catch(e){}(n||t)&&window.postMessage({event_baseid:e,action:"saveInvitee",invitee:d,reFilter:!0,joinUrl:n,eventOwner:b,descText:t},c)}}}else if(2===v){let e=!1;try{A.indexOf(C)>-1&&(e=!0)}catch(e){}if(!e)return;try{n[0][2][3][1][1][0][3][34][0]&&(e=!1)}catch(e){}try{n[0][2][3][3][1][0][3][2]&&(e=!1)}catch(e){}try{n[0][2][3][1][1][1][3][2]&&(e=!1)}catch(e){}try{void 0===n[0][2][4][0]&&(e=!1)}catch(e){}e&&window.postMessage({event_baseid:w,action:"deleteevent"},c)}}}}}),!0),x.apply(this,arguments)};var q=n.send;return n.send=function(e){var n=document.querySelector("#zoom-quick-desc"),o=document.querySelector("#zoom-quick-location");if("sync.sync"===this._path&&"string"==typeof e&&e.indexOf("f.req=")>=0){let t=e.split("&"),i=null;for(let e=0,n=t.length;e<n;e++){let n=t[e];if(n.indexOf("f.req=")>=0){try{i=JSON.parse(decodeURIComponent(n.split("f.req=")[1]))}catch(e){}break}}if(Array.isArray(i)){let t=!1,a=-2;try{let e=i[0]?.[4];if(Array.isArray(e)&&e.length)for(var r=e.length-1;r>-1;r--){let t=e[r]?.[2];if(z(t)){a=r,C();break}}}catch(e){}if(n&&""!==n.textContent){try{a>-1&&(i[0][4][a][2][0][2][3][1][2][1]=decodeURIComponent(n.textContent),t=!0,n.textContent="")}catch(e){}t||function(e){window.postMessage({event_baseid:" ",action:"recordZmlog",msgType:7,msg:{msg:"[Zoom Chrome Extension] Sync.Sync Request format exception: "+JSON.stringify(e),filename:"zm-observer.js"},operaType:3},c)}(i)}if(o&&""!==o.textContent)try{a>-1&&(i[0][4][a][2][0][2][3][3][11]=[null,null,[[[null,o.textContent]]]],t=!0,o.textContent="")}catch(e){}t&&(e=e.replace(/f\.req\=[\w\W]*?(?=&)/,"f.req="+encodeURIComponent(JSON.stringify(i))))}}else"event"===this._path&&(n&&""!==n.textContent&&(e=e.replace(/&details&/g,"&details="+n.textContent+"&")),o&&""!==o.textContent&&(e=e.replace(/&location&/g,"&location="+o.textContent+"&")));return t=e,q.apply(this,[].slice.call(arguments))},n};for(let t in e)window.XMLHttpRequest[t]=e[t]}}();