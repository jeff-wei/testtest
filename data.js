let data = {
    header: "My Page 7",
    content: "Testing"
}

window.onload = function () {
    document.getElementById('h1c').textContent = data.header;
    document.getElementById('p1c').textContent = data.content;
};
