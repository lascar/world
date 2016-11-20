# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $("#destroy_world").click ->
        $.ajax
            url: "/world/"
            type: 'DELETE'
            dataType: "text"
            success: (data) ->
                $(document.body).html(data)
