(function () {
    const editPagePlugin = (hook, vm) => {
      hook.afterEach((html) => {
          const footer = document.querySelector('footer');
          footer.innerHTML += "test";

          console.log(footer);
          console.log(html);
          return html += "test";
        });
    }

    $docsify = $docsify || {};
    $docsify.plugins = [].concat(editPagePlugin, $docsify.plugins || []);
})();
