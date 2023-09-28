import { Controller } from "stimulus";
import $ from "jquery"; 

export default class extends Controller {
  connect() {
    this.showMoreButton = this.element.querySelector(".btn.btn-secondary.m-1");

    const previousState = localStorage.getItem("buttonState");
    if (previousState === "expanded") {
      this.expandFilters();
    } else {
      this.collapseFilters();
    }

    this.showMoreButton.addEventListener("click", () => {
      if (this.expanded) {
        this.collapseFilters();
      } else {
        this.expandFilters();
      }
    });
  }

  expandFilters() {
    this.showMoreButton.innerText = "Show Less";
    localStorage.setItem("buttonState", "expanded");
    filterRows.classList.add("show");
    this.element.style.height = "370px";
    this.expanded = true;
  }

  collapseFilters() {
    this.showMoreButton.innerText = "Show More";
    localStorage.setItem("buttonState", "collapsed");
    this.element.style.height = "230px";
    filterRows.classList.remove("show");
    this.expanded = false;
  }

  clearFilters() {
    const form = document.getElementById("search-form");
    form.querySelectorAll("select").forEach((select) => {
      select.value = "";
    });
  }
}
