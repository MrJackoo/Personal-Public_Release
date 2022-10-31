$(function() {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        };
    };

    function setData(item) {
        var data = item.player;
        var jobinfo = item.job;
        $("#heading").text(item.label);
        $("#firstname").text('Firstname: ' + data.firstname);
        $("#lastname").text('Lastname: ' + data.lastname);
        $("#phone_number").text('Phone: ' + data.phone);
        if (jobinfo == "police") {
            $(".policecorruption").html(
                "<h3>Do you understand that you cannot be corrupt as police as this is a server rulebreak?</h3>"+
                "<div id=\"checkboxarea\">"+
                    "<input type=\"checkbox\" id=\"checkbox_corrupt\" class=\"checkbox\">"+
                "</div>"
            );
        };
        if (jobinfo == "ambulance") {
            $(".policecorruption").html(
                "<div>"+"</div>"
            );
        };

    };

    display(false)

    window.addEventListener("message", function(event) {
        item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true);
                setData(item);
            } else {
                display(false);
            };
        };
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post("http://jobapplications/exit_form", JSON.stringify({}));
            return
        }
    };

    $("#close").click(function() {
        $.post("http://jobapplications/exit_form", JSON.stringify({}));
        return
    })

    $("#submit").click(function() {
        let discordtag = $("#input_discord").val()
        let age = $("#input_age").val()
        let joiningreason = $("#textarea_whyjoin").val()
        let qualities = $("#textarea_qualities").val()
        let previousexp = $("#textarea_exp").val()
        let indiscordcheck = $("#checkbox_comm").is(":checked")
        let meetagereq = $("#checkbox_age").is(":checked")
        let corruptcheck = $("#checkbox_corrupt").is(":checked")
        let extras = $("#textarea_extra").val()
        $.post("http://jobapplications/send_form", JSON.stringify({
            discordid: discordtag,
            age: age,
            joinreason: joiningreason,
            qualities: qualities,
            previous: previousexp,
            indiscord: indiscordcheck,
            meetage: meetagereq,
            corruption: corruptcheck,
            extra: extras,
            job: item.job,
            label: item.label,
        }));
        return;
    });

})