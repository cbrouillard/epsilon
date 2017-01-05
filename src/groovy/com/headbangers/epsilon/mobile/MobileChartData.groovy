package com.headbangers.epsilon.mobile

class MobileChartData {

    def graphData
    def colors

    MobileChartData() {
        this.graphData = new ArrayList<GraphData>()
    }

    void specialSetGraphData(datas) {
        datas.eachWithIndex { d, idx ->
            this.graphData.add(new GraphData(key: d[0], value: d[1], index: idx))
        }
    }
}

class GraphData {
    def key
    def value
    def index
}
