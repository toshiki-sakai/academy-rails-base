document.getElementById("image").addEventListener("change", function (e) {
  const fileNameDisplay = document.getElementById("file-name");
  const fileName = e.target.files[0].name;
  fileNameDisplay.textContent = fileName;
});
