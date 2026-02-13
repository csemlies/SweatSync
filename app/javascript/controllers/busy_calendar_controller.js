import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slot", "duration", "durationHidden", "startsHidden", "form"]
  static values = { busyStarts: Array, planSessionId: Number }

  connect() {
    console.log("busy-calendar connected", {
      planSessionId: this.planSessionIdValue,
      slots: this.slotTargets.length,
      hasDurationTarget: this.hasDurationTarget
    })

    this.selected = new Set()

    const saved = new Set(this.busyStartsValue || [])
    this.slotTargets.forEach((cell) => {
      const start = cell.dataset.start
      if (saved.has(start)) {
        cell.classList.add("is-busy")
      }
    })

    this.syncHidden()
  }

  toggle(event) {
    const cell = event.currentTarget

    // If this cell represents an already-saved BusyBlock, delete it
    const busyId = cell.dataset.busyId
    if (busyId) {
      const ok = confirm("Remove this busy block?")
      if (!ok) return

      fetch(`/sessions/${this.planSessionIdValue}/busy_blocks/${busyId}`, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
          "Accept": "application/json",
        },
      }).then(() => window.location.reload())

      return
    }

    // Otherwise toggle selection (light highlight) before saving
    const start = cell.dataset.start
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
    const dur = parseInt(this.durationTarget.value, 10)
    this.durationHiddenTarget.value = dur
    this.startsHiddenTarget.value = JSON.stringify([...this.selected])
  }
}
