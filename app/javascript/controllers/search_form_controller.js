import { Controller } from "stimulus";
export default class extends Controller {
  initialize() {
    this.originalHeight = this.element.offsetHeight;
    this.expanded = true;
    this.showMoreButton = document.querySelector(".btn.btn-secondary.m-1");
  }
  toggleFilters() {
    this.expanded = !this.expanded;
    const filterRows = document.getElementById("filterRows");

    if (this.expanded) {
      this.showMoreButton.innerText = "Show Less";
      this.element.style.height = this.originalHeight + "px";
      filterRows.classList.add("show");
    } else {
      this.showMoreButton.innerText = "Show More";
      this.element.style.height = "230px";
      filterRows.classList.remove("show");
    }
  }
  clearFilters() {
    const form = document.getElementById("search-form");
    form.querySelectorAll("select").forEach((select) => {
      select.value = "";
    });
  }
}
