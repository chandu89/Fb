// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
document.addEventListener("DOMContentLoaded", function() {
  const fileInput = document.getElementById("post_image");
  const imagePreview = document.getElementById("image_preview");
  const previewContainer = document.getElementById("image_preview_container");
  const removeButton = document.getElementById("remove_image");

  fileInput.addEventListener("change", function(event) {
    const file = event.target.files[0];

    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        imagePreview.src = e.target.result;
        previewContainer.classList.remove("hidden");
      };
      reader.readAsDataURL(file);
    }
  });

  removeButton.addEventListener("click", function() {
    fileInput.value = "";
    previewContainer.classList.add("hidden");
    imagePreview.src = "";
  });

  function previewImage(event) {
    const previewImage = document.getElementById("preview-image");
    const previewContainer = document.getElementById("image-preview");
    const file = event.target.files[0];

    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        previewImage.src = e.target.result;
        previewContainer.classList.remove("hidden");
      };
      reader.readAsDataURL(file);
    }
  }

});
