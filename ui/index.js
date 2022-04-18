window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.showUI) {
        $('.outter').show();
    } else {
        $('.outter').hide();
    }
});

function sendTeam(team){
    fetch(`https://${GetParentResourceName()}/sendTeamSelected`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            teamId: team
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));
}