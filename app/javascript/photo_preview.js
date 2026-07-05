document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".photo-input").forEach(input => {
    input.addEventListener("change", event => {
      const file = event.target.files[0];
      if (!file) return;

      const slot = input.dataset.slot;
      const preview = document.getElementById(`preview-${slot}`);
      const placeholder = document.getElementById(`placeholder-${slot}`);

      const reader = new FileReader();

      reader.onload = e => {
        preview.src = e.target.result;
        preview.style.display = "block";

        if (placeholder) {
          placeholder.style.display = "none";
        }
      };

      reader.readAsDataURL(file);
    });
  });
});