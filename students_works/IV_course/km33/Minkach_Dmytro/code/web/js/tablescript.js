var data = [
        ["Білогур", "", "", "", "", "", ""],
        ["Гензель", "", ""],
        ["Горностай", "", ""],
        ["Ічанський", "", ""],
        ["Карпенко", "", ""],
        ["Лозовський", "", ""],
        ["Масюк", "", ""],
        ["Мінькач", "", ""],
        ["Пашина", "", ""],
        ["Рак", "", ""],
        ["Скаковський", "", ""],
        ["Снагощенко", "", ""],
        ["Столєтова", "", ""],
        ["Тесля", "", ""],
        ["Травєніков", "", ""],
        ["Тютюник", "", ""],
        ["Хабаров", "", ""],
        ["Шарапов", "", ""],
        ["Шевчук", "", ""],
        ["Щьоголєв", "", ""]
    ];

var container = document.getElementById('example');

greenRenderer = function(instance, td, row, col, prop, value, cellProperties) {
    Handsontable.renderers.TextRenderer.apply(this, arguments);
    td.style.backgroundColor = 'green';
};

ipValidatorRegexp = /(?:н)?/;

var hot = new Handsontable(container, {
    data: data,
    startRows: 5,
    startCols: 5,
//    cells: function (row, col, prop){
//        if (row >= 1) {
//            this.renderer = greenRenderer;
//        }
//    },
    colHeaders: ["Surname", "01/09", "08/09", "15/09", "22/09", "29/09", "06/10"],
    rowHeaders: true
});
Handsontable.Dom.addClass(table, "table-hover");