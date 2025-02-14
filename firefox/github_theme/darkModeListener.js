window
	.matchMedia("(prefers-color-scheme: dark)")
	.addEventListener("change", (e) => {
		browser.runtime.sendMessage({ scheme: e.matches ? "dark" : "light" });
	});
