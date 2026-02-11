import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slot", "duration", "durationHidden", "startsHidden", "form"]
  static values = { busyStarts: Array }

  connect() {
    this.selected = new Set()

    // mark already-saved busy blocks as dark
    const saved = new Set(this.busyStartsValue || [])
    this.slotTargets.forEach((cell) => {
      if (saved.has(cell.dataset.start)) {
        cell.classList.add("is-busy")
        cell.dataset.busy = "1"
      }
    })

    this.syncHidden()
  }

  toggle(event) {
    const cell = event.currentTarget
    const start = cell.dataset.start

    // optional: prevent selecting already-busy cells
    if (cell.dataset.busy === "1") return

    if (this.selected.has(start)) {
      this.selected.delete(start)
      cell.classList.remove("is-selected")
    } else {
      this.selected.add(start)
      cell.classList.add("is-selected")
    }

    this.syncHidden()
  }

  syncHidden() {
    // keep duration in sync
    const dur = parseInt(this.durationTarget.value, 10)
    this.durationHiddenTarget.value = dur

    // Rails params: easiest is submit as JSON string
    this.startsHiddenTarget.value = JSON.stringify([...this.selected])
  }
}
