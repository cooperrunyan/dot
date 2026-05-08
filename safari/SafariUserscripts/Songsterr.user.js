// ==UserScript==
// @name        Songsterr
// @description This is your new file, start writing code
// @match       https://*.songsterr.com/*
// ==/UserScript==

window.__ADS__ = "off";

const containerQuery = '#root > #app section#apptab + div';
const continueQuery = 'div > form[role="dialog"] > div[class*="popup"] > div > div p[class*="continue"] a';

window.addEventListener("DOMContentLoaded", e => {
    const container = document.querySelector(containerQuery);
    if (!container) {
        console.log("No Container");
        return;
    }
    
    const observer = new MutationObserver((mutationsList, observer) => {
        for (const mutation of mutationsList) {
            if (mutation.type !== 'childList') continue;
            for (const node of mutation.addedNodes) {
                if (node.nodeType !== Node.ELEMENT_NODE) continue;
                const a = node.querySelector(continueQuery);
                if (!a) continue;
                
                const id = setInterval(() => {
                    const a = document.querySelector(`${containerQuery} ${continueQuery}`);
                    if (a) { 
//                         console.log("Attempting to click");
                        a.click();
                    }
                    else { 
//                         console.log("clear");
                        clearInterval(id);
                    }
                }, 10);
                
                return;
            }
        }
    });
    
    observer.observe(container, {
        childList: true,
        subtree: true,
        attributes: false,
        characterData: false
    });
});