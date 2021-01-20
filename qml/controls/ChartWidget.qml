import QtQuick 2.12
import QtCharts 2.3
import QtQuick.Layouts 1.3

ChartView
{
    antialiasing: true
    margins.left: 0
    margins.right: 0
    margins.top: 0
    margins.bottom: 0
    backgroundColor: Qt.darker("#162170", 1.3)
    title: qsTr("Vitals History")
    titleColor: "white"

    legend.labelColor: "white"
    legend.font: Qt.font({pixelSize: 12})
    legend.markerShape: Legend.MarkerShapeCircle

    ValueAxis
    {
        id: xAxis
        tickCount: 20
        visible: false
    }

    ValueAxis
    {
        id: yAxis
        labelFormat: "%.0f"
        labelsColor: "white"
        min: 0; max: 100
        labelsFont:Qt.font({pointSize: 8})
    }

    LineSeries
    {
        id: edaGraph
        name: "Electrodermal Activity (µS)"
        axisX: xAxis
        axisY: yAxis

        XYPoint { x: 0; y: 0.5 }
        XYPoint { x: 1; y: 1 }
        XYPoint { x: 2; y: 3 }
        XYPoint { x: 3; y: 2.9 }
        XYPoint { x: 4; y: 6 }
        XYPoint { x: 5; y: 8 }
        XYPoint { x: 6; y: 12 }
        XYPoint { x: 7; y: 8 }
        XYPoint { x: 8; y: 9 }
        XYPoint { x: 9; y: 12 }
        XYPoint { x: 10; y: 12 }
        XYPoint { x: 11; y: 8 }
        XYPoint { x: 12; y: 9 }
        XYPoint { x: 13; y: 12 }
        XYPoint { x: 14; y: 12 }
        XYPoint { x: 15; y: 12 }
        XYPoint { x: 16; y: 8 }
        XYPoint { x: 17; y: 9 }
        XYPoint { x: 18; y: 5 }
        XYPoint { x: 19; y: 9 }
    }

    LineSeries
    {
        id: bpmGraph
        name: "Heart Beats (bpm)"
        axisX: xAxis
        axisY: yAxis

        XYPoint { x: 0; y: 72 }
        XYPoint { x: 1; y: 67 }
        XYPoint { x: 2; y: 78 }
        XYPoint { x: 3; y: 86 }
        XYPoint { x: 4; y: 77 }
        XYPoint { x: 5; y: 97 }
        XYPoint { x: 6; y: 80 }
        XYPoint { x: 7; y: 78 }
        XYPoint { x: 8; y: 67 }
        XYPoint { x: 9; y: 68 }
        XYPoint { x: 10; y: 72 }
        XYPoint { x: 11; y: 67 }
        XYPoint { x: 12; y: 78 }
        XYPoint { x: 13; y: 86 }
        XYPoint { x: 14; y: 77 }
        XYPoint { x: 15; y: 97 }
        XYPoint { x: 16; y: 80 }
        XYPoint { x: 17; y: 78 }
        XYPoint { x: 18; y: 67 }
        XYPoint { x: 19; y: 68 }
    }

    function shuffleList()
    {
        var xVal = bpmGraph.at(19).x + 1
        var yBpm = bpmGraph.at(12).y
        var yEda = edaGraph.at(6).y

        xAxis.min = xVal-19
        xAxis.max = xVal

        bpmGraph.remove(0)
        bpmGraph.append(xVal, yBpm)

        edaGraph.remove(0)
        edaGraph.append(xVal, yEda)

        b_ = yBpm;
        c_ = yEda;

        return {b:b_,c:c_}
    }
}

