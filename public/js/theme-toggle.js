(function () {
  var root = document.documentElement;
  var button = document.getElementById("theme-toggle");

  if (!button) return;

  function labelFor(theme) {
    return theme === "dark" ? "Light mode" : "Dark mode";
  }

  function applyTheme(theme) {
    root.setAttribute("data-theme", theme);
    localStorage.setItem("theme", theme);
    button.textContent = labelFor(theme);
  }

  var current = root.getAttribute("data-theme") || "light";
  button.textContent = labelFor(current);

  button.addEventListener("click", function () {
    var next = (root.getAttribute("data-theme") || "light") === "dark" ? "light" : "dark";
    applyTheme(next);
  });
})();
