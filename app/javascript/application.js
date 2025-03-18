// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
document.addEventListener("DOMContentLoaded", function () {
    if (localStorage.getItem("scrollPosition")) {
        setTimeout(() => {
            window.scrollTo(0, localStorage.getItem("scrollPosition"));
            localStorage.removeItem("scrollPosition");
        }, 10);
    }

    function salvarScrollAntesDeEnviar() {
        localStorage.setItem("scrollPosition", window.scrollY);
    }

    document.querySelectorAll("form, a[data-method], button[data-method]").forEach((element) => {
        element.addEventListener("submit", salvarScrollAntesDeEnviar);
        element.addEventListener("click", salvarScrollAntesDeEnviar);
    });
});