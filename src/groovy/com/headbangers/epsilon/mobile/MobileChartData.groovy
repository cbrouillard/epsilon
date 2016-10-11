package com.headbangers.epsilon.mobile

class MobileChartData {

    def graphData
    def colors

    MobileChartData (){
        this.graphData = new ArrayList<GraphData>()
    }

    void setGraphData(graphData) {
        graphData.each { d ->
            this.graphData.add (new GraphData(key:d[0], value:d[1]))
        }
    }
}

class GraphData{
    def key
    def value
}
