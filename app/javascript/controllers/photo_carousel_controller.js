import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "dot"]

  connect() {
    this.index = 0
    this.show()
  }

  next() {
    if (this.slideTargets.length === 0) return
    this.index = (this.index + 1) % this.slideTargets.length
    this.show()
  }

  previous() {
    if (this.slideTargets.length === 0) return
    this.index = (this.index - 1 + this.slideTargets.length) % this.slideTargets.length
    this.show()
  }

  show() {
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle("active", i === this.index)
    })

    this.dotTargets.forEach((dot, i) => {
      dot.classList.toggle("active", i === this.index)
    })
  }
}