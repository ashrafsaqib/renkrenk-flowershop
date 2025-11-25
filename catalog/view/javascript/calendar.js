/**
 * Calendar Component for Date Selection
 * Usage: new Calendar(targetElementId, options)
 */
(function(window) {
  'use strict';

  function Calendar(targetElementId, options) {
    this.targetElement = document.getElementById(targetElementId);
    if (!this.targetElement) {
      console.error('Calendar: Target element not found:', targetElementId);
      return;
    }

    // Default options
    this.options = Object.assign({
      minDate: null, // null or Date object
      maxDate: null, // null or Date object
      defaultDate: null, // null or Date object (defaults to today)
      onDateSelect: null, // callback function(dateString)
      containerClass: 'calendar-container',
      selectedClass: 'selected',
      disabledClass: 'disabled',
      todayClass: 'today'
    }, options || {});

    this.today = new Date();
    this.today.setHours(0, 0, 0, 0);
    
    this.selectedDate = this.options.defaultDate ? new Date(this.options.defaultDate) : new Date(this.today);
    this.currentMonth = this.selectedDate.getMonth();
    this.currentYear = this.selectedDate.getFullYear();

    this.monthNames = ["January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"];
    this.dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    this.init();
  }

  Calendar.prototype.init = function() {
    // Create calendar container
    this.calendarDiv = document.createElement('div');
    this.calendarDiv.className = this.options.containerClass;
    this.calendarDiv.style.maxWidth = '100%';
    this.calendarDiv.style.margin = '0 auto';
    this.targetElement.appendChild(this.calendarDiv);

    // Add default styles if not present
    if (!document.getElementById('calendar-styles')) {
      this.addStyles();
    }

    this.render();
  };

  Calendar.prototype.addStyles = function() {
    var style = document.createElement('style');
    style.id = 'calendar-styles';
    style.textContent = `
      .calendar-container {
        background-color: #f8f9fa;
      }
      .calendar-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
        padding: 0.5rem;
        background-color: #f8f9fa;
        border-radius: 0.25rem;
      }
      .calendar-header button {
        background: none;
        border: none;
        font-size: 1.2rem;
        cursor: pointer;
        padding: 0.25rem 0.75rem;
      }
      .calendar-header h6 {
        margin: 0;
        font-weight: 600;
      }
      .calendar-grid {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        gap: 0.5rem;
        padding-bottom: 0.5rem;
      }
      .calendar-day-header {
        text-align: center;
        font-weight: 600;
        font-size: 0.875rem;
        color: #6c757d;
        padding: 0.5rem;
      }
      .calendar-day {
        aspect-ratio: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.2s;
        background-color: #fff;
        font-size: 0.875rem;
        border-radius: 50%;
      }
      .calendar-day:hover:not(.disabled):not(.other-month) {
        background-color: #e9ecef;
        border-color: #020202ff;
      }
      .calendar-day.selected {
        background-color: #000000ff;
        color: white;
        border-color: #000000ff;
        font-weight: 600;
      }
      .calendar-day.disabled {
        background-color: #f8f9fa;
        color: #adb5bd;
        cursor: not-allowed;
      }
      .calendar-day.other-month {
        color: #ced4da;
      }
      .calendar-day.today {
        border: 2px solid #010101ff;
        font-weight: 600;
      }
    `;
    document.head.appendChild(style);
  };

  Calendar.prototype.render = function() {
    var firstDay = new Date(this.currentYear, this.currentMonth, 1).getDay();
    var daysInMonth = new Date(this.currentYear, this.currentMonth + 1, 0).getDate();
    var daysInPrevMonth = new Date(this.currentYear, this.currentMonth, 0).getDate();

    var html = '<div class="calendar-header">';
    html += '<button type="button" class="calendar-prev">&laquo;</button>';
    html += '<h6>' + this.monthNames[this.currentMonth] + ' ' + this.currentYear + '</h6>';
    html += '<button type="button" class="calendar-next">&raquo;</button>';
    html += '</div>';

    html += '<div class="calendar-grid">';
    
    // Day headers
    for (var i = 0; i < 7; i++) {
      html += '<div class="calendar-day-header">' + this.dayNames[i] + '</div>';
    }

    // Previous month days
    for (var i = firstDay - 1; i >= 0; i--) {
      var day = daysInPrevMonth - i;
      html += '<div class="calendar-day other-month">' + day + '</div>';
    }

    // Current month days
    for (var day = 1; day <= daysInMonth; day++) {
      var date = new Date(this.currentYear, this.currentMonth, day);
      date.setHours(0, 0, 0, 0);
      var classes = ['calendar-day'];
      var disabled = this.isDateDisabled(date);
      
      if (disabled) {
        classes.push(this.options.disabledClass);
      }
      
      if (date.getTime() === this.today.getTime()) {
        classes.push(this.options.todayClass);
      }

      if (this.selectedDate && date.getTime() === this.selectedDate.getTime()) {
        classes.push(this.options.selectedClass);
      }

      var dateStr = this.formatDate(date);
      html += '<div class="' + classes.join(' ') + '" data-date="' + dateStr + '"';
      if (disabled) {
        html += ' style="pointer-events: none;"';
      }
      html += '>' + day + '</div>';
    }

    // Next month days
    var totalCells = firstDay + daysInMonth;
    var remainingCells = totalCells % 7 === 0 ? 0 : 7 - (totalCells % 7);
    for (var day = 1; day <= remainingCells; day++) {
      html += '<div class="calendar-day other-month">' + day + '</div>';
    }

    html += '</div>';
    this.calendarDiv.innerHTML = html;

    this.attachEventListeners();
  };

  Calendar.prototype.attachEventListeners = function() {
    var self = this;

    // Previous month button
    var prevBtn = this.calendarDiv.querySelector('.calendar-prev');
    if (prevBtn) {
      prevBtn.addEventListener('click', function() {
        self.previousMonth();
      });
    }

    // Next month button
    var nextBtn = this.calendarDiv.querySelector('.calendar-next');
    if (nextBtn) {
      nextBtn.addEventListener('click', function() {
        self.nextMonth();
      });
    }

    // Calendar day clicks
    var days = this.calendarDiv.querySelectorAll('.calendar-day:not(.' + this.options.disabledClass + '):not(.other-month)');
    days.forEach(function(dayEl) {
      dayEl.addEventListener('click', function() {
        self.selectDate(this.getAttribute('data-date'));
      });
    });
  };

  Calendar.prototype.previousMonth = function() {
    this.currentMonth--;
    if (this.currentMonth < 0) {
      this.currentMonth = 11;
      this.currentYear--;
    }
    this.render();
  };

  Calendar.prototype.nextMonth = function() {
    this.currentMonth++;
    if (this.currentMonth > 11) {
      this.currentMonth = 0;
      this.currentYear++;
    }
    this.render();
  };

  Calendar.prototype.selectDate = function(dateStr) {
    this.selectedDate = new Date(dateStr + 'T00:00:00');
    
    // Update visual selection
    var days = this.calendarDiv.querySelectorAll('.calendar-day');
    days.forEach(function(el) {
      el.classList.remove('selected');
    });
    
    var selectedDay = this.calendarDiv.querySelector('[data-date="' + dateStr + '"]');
    if (selectedDay) {
      selectedDay.classList.add('selected');
    }

    // Trigger callback
    if (typeof this.options.onDateSelect === 'function') {
      this.options.onDateSelect(dateStr);
    }
  };

  Calendar.prototype.isDateDisabled = function(date) {
    if (this.options.minDate && date < this.options.minDate) {
      return true;
    }
    if (this.options.maxDate && date > this.options.maxDate) {
      return true;
    }
    return false;
  };

  Calendar.prototype.formatDate = function(date) {
    var year = date.getFullYear();
    var month = String(date.getMonth() + 1).padStart(2, '0');
    var day = String(date.getDate()).padStart(2, '0');
    return year + '-' + month + '-' + day;
  };

  Calendar.prototype.getValue = function() {
    return this.selectedDate ? this.formatDate(this.selectedDate) : null;
  };

  Calendar.prototype.setValue = function(dateStr) {
    if (dateStr) {
      this.selectedDate = new Date(dateStr + 'T00:00:00');
      this.currentMonth = this.selectedDate.getMonth();
      this.currentYear = this.selectedDate.getFullYear();
      this.render();
    }
  };

  Calendar.prototype.destroy = function() {
    if (this.calendarDiv) {
      this.calendarDiv.remove();
    }
  };

  // Export to window
  window.Calendar = Calendar;

})(window);
