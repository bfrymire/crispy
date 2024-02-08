(function () {
    const footerPlugin = (hook, vm) => {
        const year = new Date().getFullYear() || 2020;
        const footer = [
          '<div style="margin-top:3rem;"><p align="right">',
          `Crispy &copy; ${year} by <a target="_blank" href="https://github.com/bfrymire">Brent Frymire</a>`,
          '</br>',
          `Docs created using <a rel="nofollow" target="_blank" href="https://docsify.js.org/">Docsify</a>`,
          '</p></div>',
        ].join('');
    
        hook.afterEach((html) => html + footer);
    }

    $docsify = $docsify || {};
    $docsify.plugins = [].concat(footerPlugin, $docsify.plugins || []);
})();
