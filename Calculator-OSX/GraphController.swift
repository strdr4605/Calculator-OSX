//
//  GraphController.swift
//  Calculator-OSX
//
//  Created by Hackintosh on 4/6/17.
//  Copyright © 2017 Dragos Strainu. All rights reserved.
//

import Cocoa
import Foundation
import CorePlot

class GraphController: NSViewController, CPTPlotDataSource {
    @IBOutlet weak var hostView: CPTGraphHostingView!
    
    var function: String = ""
    
    var plotData = [Double]()
    
    var plotPositions = [Double]()
    
    let oneDay : Double = 24 * 60 * 60;
    
    let logic: MathLogic = MathLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        function = function.replacingOccurrences(of: "y", with: "")
        function = function.replacingOccurrences(of: "=", with: "")
        initPlot()
        // Do any additional setup after loading the view.
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func initPlot() {
        configureHostView()
        configureGraph()
        configureChart()
        configureLegend()
    }
    
    func configureHostView() {
        hostView.allowPinchScaling = false
    }
    
    func configureGraph() {
        //let refDate = DateFormatter().date(from: "12:00 Oct 29, 2009")
        
        // 1 - Create and configure the graph
        let graph = CPTXYGraph(frame: hostView.bounds)
        hostView.hostedGraph = graph
        graph.paddingLeft = 0.0
        graph.paddingTop = 0.0
        graph.paddingRight = 0.0
        graph.paddingBottom = 0.0
        
        // 2 - Create text style
        let textStyle: CPTMutableTextStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.black()
        textStyle.fontName = "HelveticaNeue-Bold"
        textStyle.fontSize = 12.0
        textStyle.textAlignment = .center
        
        // 3 - Set graph title and text style
        graph.title = "Plot of function f(x)=" + function
        graph.titleTextStyle = textStyle
        graph.titlePlotAreaFrameAnchor = CPTRectAnchor.topLeft
        //hostView.hostedGraph = graph
        
        //let theme = CPTTheme(named: .darkGradientTheme)
        //graph.apply(theme)
        
        // Axes
        let axisSet = graph.axisSet as! CPTXYAxisSet
        if let x = axisSet.xAxis {
            x.majorIntervalLength   = 1.0
            x.orthogonalPosition    = 0.0
            x.minorTicksPerInterval = 0;
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .short
//            let timeFormatter = CPTTimeFormatter(dateFormatter:dateFormatter)
//            timeFormatter.referenceDate = refDate;
//            x.labelFormatter            = timeFormatter;
        }
        
        if let y = axisSet.yAxis {
            y.majorIntervalLength   = 1.0
            y.minorTicksPerInterval = 0
            y.orthogonalPosition    = 0
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .short
//            let timeFormatter = CPTTimeFormatter(dateFormatter:dateFormatter)
//            timeFormatter.referenceDate = refDate;
//            y.labelFormatter = timeFormatter
//            y.labelingPolicy = .none
        }
        
        let plotSpace = graph.defaultPlotSpace as! CPTXYPlotSpace
        
        plotSpace.xRange = CPTPlotRange(location:-4.0, length:8)
        plotSpace.yRange = CPTPlotRange(location:-4.0, length:8)
        
    }
    
    
    func configureChart() {
        // 1 - Get a reference to the graph
        let graph = hostView.hostedGraph!
        
        newPlotData()
        
        let dataSourceLinePlot = CPTScatterPlot(frame: .zero)
        dataSourceLinePlot.identifier = NSString.init(string: "Date Plot")
        
        if let lineStyle = dataSourceLinePlot.dataLineStyle?.mutableCopy() as? CPTMutableLineStyle {
            lineStyle.lineWidth              = 3.0
            lineStyle.lineColor              = .black()
            dataSourceLinePlot.dataLineStyle = lineStyle
        }
        
        dataSourceLinePlot.dataSource = self
        
        // 5 - Add chart to graph
        graph.add(dataSourceLinePlot)
    }
    
    func configureLegend() {
    }
    
    func newPlotData()
    {
        var newData = [Double]()
        var newPositions = [Double]()
        var currentData: String = ""
        for i in -100 ..< 101 {
            //newData.append(sqrt(1 - pow(Double(i) / 10,2)))
            currentData = function.replacingOccurrences(of: "x", with: String(Double(i) / 10))
            newData.append(Double(logic.getExpressionValue(expression: currentData))!)
            newPositions.append(Double(i) / 10)
        }
        print(newData)
        self.plotData = newData
        self.plotPositions = newPositions
    }
    
    func numberOfRecords(for plot: CPTPlot) -> UInt    {
        return UInt(self.plotData.count)
    }
    
    func number(for plot: CPTPlot, field: UInt, record: UInt) -> Any?
    {
        switch CPTScatterPlotField(rawValue: Int(field))! {
        case .X:
            return self.plotPositions[Int(record)] as NSNumber
            
        case .Y:
            return self.plotData[Int(record)] as NSNumber
        }
    }
    
    func dataLabel(for plot: CPTPlot, record idx: UInt) -> CPTLayer? {
        return nil
    }
    
    func sliceFill(for pieChart: CPTPieChart, record idx: UInt) -> CPTFill? {
        return nil
    }
    
    func legendTitle(for pieChart: CPTPieChart, record idx: UInt) -> String? {
        return nil
    }
    
}
