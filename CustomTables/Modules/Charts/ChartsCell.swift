//
//  ChartsCells.swift
//  CustomTables
//
//  Created by Arturo Ventura on 13/10/22.
//

import UIKit

class ChartsCell: UITableViewCell, CustomTablesCell {
    
    static var reusableName: String = "ChartsCell"
    
    weak var titleLabel: UILabel?
    weak var pieChartView: PieChartView?
    weak var stackInfo: UIStackView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let titleLabel = UILabel.CustomInstance(font: .Bold, size: .Big, color: .Viking)
        self.titleLabel = titleLabel
        
        let pieChartView = PieChartView()
        pieChartView.anchor(size: CGSize(width: 300, height: 300))
        self.pieChartView = pieChartView
        
        let stackInfo = UIStackView.CustomInstance(axis: .vertical)
        self.stackInfo = stackInfo
        
        let mainStack = UIStackView.CustomInstance(axis: .vertical, alignment: .center, spacing: 8, arrangedSubviews: [titleLabel, pieChartView, stackInfo])
        
        contentView.addSubviewFill(mainStack, padding: .axisSame(vertical: 16, horizontal: 8))
    }
    
    func fillData(data: SurveyChart?) {
        titleLabel?.text = data?.title
        pieChartView?.segments = data?.content.enumerated().map({ survey in
            Segment(color: UIColor.GetColorFor(survey.offset), value: CGFloat(survey.element.value ?? 0))
        }) ?? []
        pieChartView?.setNeedsDisplay()
        self.stackInfo?.arrangedSubviews.forEach({self.stackInfo?.removeArrangedSubview($0)})
        if let arrayStacks = data?.content.chunked(into: 2).enumerated().map({ listSurvey -> UIView in
            let first = ChartInfoView(color: UIColor.GetColorFor(listSurvey.offset * 2), name: listSurvey.element.first?.name, percent: listSurvey.element.first?.value)
            let stack = UIStackView.CustomInstance(axis: .horizontal, distribution: .fillEqually, spacing: 8, arrangedSubviews: [first])
            if listSurvey.element.count > 1 {
                let second = ChartInfoView(color: UIColor.GetColorFor(listSurvey.offset * 2 + 1), name: listSurvey.element.last?.name, percent: listSurvey.element.last?.value)
                stack.addArrangedSubview(second)
            }
            return stack
        }) {
            arrayStacks.forEach({stackInfo?.addArrangedSubview($0)})
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ChartInfoView: UIView {
    init(color: UIColor?, name: String?, percent: Int?) {
        super.init(frame: .zero)
        let dot = UIView()
        dot.layer.cornerRadius = 10
        dot.backgroundColor = color
        addSubviewAnchor(dot, top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, padding: .allSame(8), size: CGSize(width: 20, height: 20))
        let label = UILabel.CustomInstance(font: .Regular, size: .Regular, text: "\(name ?? "") \(percent ?? 0)%")
        addSubviewAnchor(label, top: topAnchor, leading: dot.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .allSame(8))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
