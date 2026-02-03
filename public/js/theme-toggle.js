(function () {
  var root = document.documentElement;
  var button = document.getElementById("theme-toggle");

  if (!button) return;

  function applyTheme(theme) {
    root.setAttribute("data-theme", theme);
    localStorage.setItem("theme", theme);
    button.setAttribute("aria-label", theme === "dark" ? "Switch to light mode" : "Switch to dark mode");
  }

  var current = root.getAttribute("data-theme") || "light";
  button.setAttribute("aria-label", current === "dark" ? "Switch to light mode" : "Switch to dark mode");

  button.addEventListener("click", function () {
    var next = (root.getAttribute("data-theme") || "light") === "dark" ? "light" : "dark";
    applyTheme(next);
  });
})();
