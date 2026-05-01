// -----------------------------------------------
// Mobile nav toggle
// -----------------------------------------------
(function () {
  const toggle = document.querySelector(".nav__toggle");
  const links = document.querySelector(".nav__links");

  if (!toggle || !links) return;

  toggle.addEventListener("click", function () {
    const open = links.classList.toggle("is-open");
    toggle.classList.toggle("is-open", open);
    toggle.setAttribute("aria-expanded", open);
  });

  // Close on nav link click (mobile)
  links.querySelectorAll(".nav__link").forEach(function (link) {
    link.addEventListener("click", function () {
      links.classList.remove("is-open");
      toggle.classList.remove("is-open");
      toggle.setAttribute("aria-expanded", false);
    });
  });
})();

// -----------------------------------------------
// Highlight active nav link based on current path
// -----------------------------------------------
(function () {
  const path = window.location.pathname;
  document.querySelectorAll(".nav__link").forEach(function (link) {
    const href = link.getAttribute("href");
    if (!href) return;
    // Match section pages (/experience/, /projects/, etc.)
    if (href !== "/" && path.startsWith(href.replace(/#.*/, ""))) {
      // Reset all other active elements
      document.querySelectorAll(".active").forEach(function (link) {
        link.classList.remove("active");
      });
      // Mark this tab as active
      link.classList.add("active");
    }
  });
})();
