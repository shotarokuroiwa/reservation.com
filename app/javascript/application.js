// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const toggle = document.querySelector(".menu-toggle");
  const nav = document.querySelector(".nav");

  if (!toggle) return;

  toggle.addEventListener("click", () => {
    nav.classList.toggle("open");
  });
});

document.addEventListener("turbo:load", () => {
  const button = document.getElementById("userMenuButton");
  const menu = document.getElementById("userMenu");

  if (!button || !menu) return;

  button.addEventListener("click", (e) => {
    e.stopPropagation();
    menu.style.display = menu.style.display === "block" ? "none" : "block";
  });

  document.addEventListener("click", () => {
    menu.style.display = "none";
  });
});

const userMenuButton = document.getElementById("userMenuButton");
const userMenu = document.querySelector(".hamburger-menu");
const userMenuWrapper = document.querySelector(".user-menu");

let isHoverActive = false;

// マウス hover 入り
userMenuWrapper.addEventListener("mouseenter", () => {
  userMenu.style.display = "flex";
  isHoverActive = true;
});

// マウス hover 出
userMenuWrapper.addEventListener("mouseleave", () => {
  userMenu.style.display = "none";
  isHoverActive = false;
});

// クリックしたときに強制的に hover をリセット
userMenuButton.addEventListener("click", (e) => {
  if (!isHoverActive) {
    userMenu.style.display = "flex";
    isHoverActive = true;
  } else {
    userMenu.style.display = "none"; 
    isHoverActive = false;
  }
});
