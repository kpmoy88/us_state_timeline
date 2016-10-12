# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#Current state number
curState = 0

#Set horizontal scrollbar to end
$(window).resize ->
  $('.timeline_section').scrollLeft document.getElementById('timeline_container').scrollWidth
  return

#Start US State timeline
$(document).ready ->
  $('#startTimeline').click ->
    $('.timeline_start').hide()
    $('.timeline_section').show()
    $('.start_area').hide()
    $('.interactive_area').slideDown("slow")
    $('#tl_left_div').addClass "deactivate"
    return
  return
    
#Display next state in timeline
$(document).ready ->
  $('.nextUSstate').click ->
    if curState < 50
      nextStateSlide()
      turnOnButtons()
    return
  return

#Go to previous state in timeline and remove current displayed state
$(document).ready ->
  $('.prevUSstate').click ->
    if curState > 0
       prevStateSlide()
       turnOnButtons()
       if curState == 0
          $('.map_image').attr 'src', $('.tc_first').data('map-image')
    return
  return

#Changes map image, current state number and changes classes on state
nextStateSlide = ->
  first = $('.tb_state.not-visible').first()
  first.removeClass ' not-visible '
  first.addClass ' visible '
  first.toggle()
  curState++
  $('.timeline_section').animate { scrollLeft: '+=230' }, 100
  $('.map_image').attr 'src', $('#state_el_' + curState).data('map-image')
  if curState == 50 
    stopAutoSlide()
  return

#Changes map image, current state number and changes classes on state
prevStateSlide = ->
   last = $('.tb_state.visible').last()
   last.removeClass ' visible '
   last.addClass ' not-visible '
   last.toggle()
   curState--
   #$('.timeline_section').animate { scrollLeft: '-=230' }, 100
   $('.map_image').attr 'src', $('#state_el_' + curState).data('map-image')
   if curState == 0 
    stopAutoSlide()
   return

#Stop autoplay or autoreverse
stopAutoSlide = ->
    turnOnButtons()
    $('#stopUSstate').prop 'disabled', true
    clearInterval intervalHolder
    return
  

#Variable for stopping interval
intervalHolder = undefined

#Goes through state timeline without user input
$(document).ready ->
  $('#playUSstate').click ->
    if curState < 50
      disableButtons()
      $('#stopUSstate').prop 'disabled', false
      intervalHolder = setInterval(nextStateSlide, 1000)
    return
  return
#Stops autoplay of state timeline
$(document).ready ->
  $('#stopUSstate').click ->
    turnOnButtons()
    $('#stopUSstate').prop 'disabled', true
    clearInterval intervalHolder
    return
  return
#Goes through state timeline without user input in reverse
$(document).ready ->
  $('#reverseUSstate').click ->
    if curState >= 1
      disableButtons()
      $('#stopUSstate').prop 'disabled', false
      intervalHolder = setInterval(prevStateSlide, 1000)
    return
  return

#Adds or removes states from timeline section
QuickState = (callback, repetitions) ->
  x = 0
  intervalID = window.setInterval((->
    callback()
    if ++x == repetitions
      window.clearInterval intervalID
      turnOnButtons()
    return
  ), 100)
  return

#Jump to the selected state when user selects state name from dropdown list
$(document).ready ->
  $('#ddl_states_name').change ->
    disableButtons()
    if $('#ddl_states_name').val() > curState
      nextDistance = $('#ddl_states_name').val() - curState
      QuickState nextStateSlide, nextDistance
    else
      prevDistance = curState - $('#ddl_states_name').val()
      QuickState prevStateSlide, prevDistance
    return
  return  
#Jump to the selected state when user selects number from dropdown list
$(document).ready ->
  $('#ddl_states_num').change ->
    disableButtons()
    if $('#ddl_states_num').val() > curState
      nextDistance = $('#ddl_states_num').val() - curState
      QuickState nextStateSlide, nextDistance
    else
      prevDistance = curState - $('#ddl_states_num').val()
      QuickState prevStateSlide, prevDistance
    return
  return

#Disable all buttons depending on curState position
disableButtons = ->
  console.log "Disabled Buttons"
  $('#playUSstate').prop 'disabled', true
  $('#reverseUSstate').prop 'disabled', true
  $('.prevUSstate').prop 'disabled', true
  $('.nextUSstate').prop 'disabled', true
  $('#ddl_states_name').prop 'disabled', true
  $('#ddl_states_num').prop 'disabled', true
  $('#stopUSstate').prop 'disabled', true
  $('#tl_left_div').addClass "deactivate"
  $('#tl_right_div').addClass "deactivate"
      
#Turn on or off buttons depending on curState position
turnOnButtons = ->
  $('#ddl_states_name').prop 'disabled', false
  $('#ddl_states_num').prop 'disabled', false
  $('#stopUSstate').prop 'disabled', true
  $('#tl_left_div').removeClass "deactivate"
  $('#tl_right_div').removeClass "deactivate"
  if curState == 0
    $('#playUSstate').prop 'disabled', false
    $('#reverseUSstate').prop 'disabled', true
    $('.prevUSstate').prop 'disabled', true
    $('.nextUSstate').prop 'disabled', false
    $('#tl_left_div').addClass "deactivate"
  else if curState == 50
    $('#playUSstate').prop 'disabled', true
    $('#reverseUSstate').prop 'disabled', false
    $('.prevUSstate').prop 'disabled', false
    $('.nextUSstate').prop 'disabled', true
    $('#tl_right_div').addClass "deactivate"
  else
    $('#playUSstate').prop 'disabled', false
    $('#reverseUSstate').prop 'disabled', false
    $('.prevUSstate').prop 'disabled', false
    $('.nextUSstate').prop 'disabled', false
      
#Modal Javascript    
$(document).ready ->
  $('.state_btn').click ->
    document.getElementById('modal_state_name').innerHTML = $('#state_el_' + $(this).data('state-id')).data('state-name')
    $('#modal_state_img').attr 'src', $('#state_el_' + curState).data('state-image')
    document.getElementById('modal_union_date').innerHTML = "<span>Entered Union:</span><br />" + $('#state_el_' + $(this).data('state-id')).data('enter-union')
    $('#state_facts').attr 'href', $('#state_el_' + curState).data('facts-link')
    document.getElementById('stateModal').style.display = 'block'
    return
  return

#Opens new tab with State's Facts on FactMonster
$(document).ready ->
  $('#state_facts').click ->
    window.open $('#state_facts').attr('href'), '_blank'
    return
  return
    
#Close modal dialog on x button
$(document).ready ->
  $('#closeX').click ->
    document.getElementById('stateModal').style.display = "none";
    return
  return
    
#Close modal dialog if user touches anywhere outside dialog box
$(document).ready ->
  window.onclick = (event) ->
    if event.target == document.getElementById('stateModal')
      document.getElementById('stateModal').style.display = 'none'
    return
  return