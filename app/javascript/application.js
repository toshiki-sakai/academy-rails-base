// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";

// モーダルを表示するためのコードを追加
document.addEventListener("turbo:load", () => {
  const modalElement = document.getElementById("modal"); // モーダル表示をする際のIDを指定
  if (modalElement) {
    const modal = new bootstrap.Modal(modalElement); // Bootstrapのモーダルを初期化
    modal.show(); // モーダルを表示
  }
});
