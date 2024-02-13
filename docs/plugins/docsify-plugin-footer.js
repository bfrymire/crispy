(function () {
    const footerPlugin = (hook, vm) => {
      hook.afterEach((html) => {
        const is404 = html.includes('id="not-found"');
        const year = new Date().getFullYear() || 2020;
        const footerBegin = '<footer style="margin-top:3rem;"><p align="right">';
        const footerEnd = '</p></footer>';
        const footerItems = [
          `Crispy &copy; ${year} by <a target="_blank" href="https://github.com/bfrymire">Brent Frymire</a>`,
          `Docs created using <a rel="nofollow" target="_blank" href="https://docsify.js.org/">Docsify</a>`,
        ];
        if (vm.route.file) {
            const link = `//github.com/bfrymire/crispy/blob/docs/docs/${is404 ? '_404.md' : vm.route.file}`;
            const editLink = `<a href="${link}" target="_blank">Edit this page on GitHub</a>`;
            footerItems.unshift(editLink);
          }
          return html + `${footerBegin}${footerItems.join('</br>')}${footerEnd}`;
        });
    }

    $docsify = $docsify || {};
    $docsify.plugins = [].concat(footerPlugin, $docsify.plugins || []);
})();
