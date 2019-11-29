//
//  ViewController.swift
//  Calc
//
//  Created by HT-19R1108 on 2019/11/18.
//  Copyright © 2019 HT-19R1108. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK: - Fields
    
    let labels:[String] = ["AC","+/-","%","÷","7","8","9","×","4","5","6","-","1","2","3","+","0",".","="]
    let num_dic :Dictionary = [4:7.0,5:8.0,6:9.0,8:4.0,9:5.0,10:6.0,12:1.0,13:2.0,14:3.0,16:0.0]
    var input_left:Double = 0;
    var input_right:Double = 0;
    var result:Double = 0;
    var isLeft:Bool = true;
    var val:Double?
    var operators:Dictionary = [3:"÷",7:"×",11:"-",15:"+"]
    var current_operator:String?
    var commands:Dictionary = [0:"AC",1:"+/-",2:"%",17:".",18:"="]
    var isInteger:Bool = true
    
    @IBOutlet weak var numbers_Panel: UICollectionView!
    @IBOutlet weak var display_label: UILabel!
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        numbers_Panel.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Number", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.blue
        let button = cell.contentView.viewWithTag(1) as! UIButton
        //    print(indexPath.item)
        print(labels[indexPath.item])
        button.setTitle(labels[indexPath.item], for: UIControl.State.normal)
        
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.titleLabel?.baselineAdjustment = .alignCenters

        button.frame = CGRect(x: 0,y: 0,width: cell.frame.width,height: cell.frame.height)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.cyan.cgColor
        button.tag = indexPath.item
        print("frame button : \(button.frame)")
        print("frame cell :\(cell.frame)")
        print("layer cell : \(cell.layer)")
        //    print(label.text!)
        //    print("a")
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 10
        print(numbers_Panel.bounds)
        let cellSize : CGFloat = (numbers_Panel.bounds.width - 10) / 4
        if(indexPath.item == 16){
            return CGSize(width: cellSize*2, height: cellSize)
        }else{
            return CGSize(width: cellSize, height: cellSize)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func input_num(_ sender: UIButton) {
        print("sender tag : \(sender.tag)")
        print("label : \(labels[sender.tag])")
//        print(num_dic[sender.tag]!)
//        print(type(of:num_dic[sender.tag]!))
        if(num_dic[sender.tag] != nil){
//            print("num : \(num_dic[sender.tag])")
            print("operator : \(operators[sender.tag])")
            print("current operator : \(current_operator)")
            if(isLeft){
                if(input_left == 0 && num_dic[sender.tag]! == 0){
                    return
                }else{
                    input_left = input_left * 10 + num_dic[sender.tag]!
                    display_label.text = display(display_num: input_left)
                }
            }else{
                if(input_right == 0 && num_dic[sender.tag]! == 0){
                    return
                }else{
                    input_right = input_right * 10 + num_dic[sender.tag]!
                    display_label.text = display(display_num: input_right)
                }
            }
        }else if(operators[sender.tag] != nil){
            print("operator setting")
            current_operator = operators[sender.tag]
            if(isLeft){
                isLeft = !isLeft
            }else{
                calc()
                display_label.text = display(display_num: result)
            }
        }else if(commands[sender.tag] != nil){
            do_command(tag: sender.tag)
        }
    }
    
    private func calc(){
        print("calc")
        guard current_operator != nil else {
            print("a")
            return
        }
        switch current_operator {
        case "+":
            result = input_left + input_right
            print("+")
            break
        case "-":
            result = input_left - input_right
            break
        case "÷":
            result = input_left / input_right
            break
        case "×":
            result = input_left * input_right
            break
        default:
            break
        }
        input_left = result
    }
    
    private func do_command(tag:Int){
        guard let command:String = commands[tag] else{
            return
        }
        switch command {
        case "AC":
            input_left = 0
            input_right = 0
            current_operator = nil
            isLeft = true
            display_label.text = display(display_num: input_left)
            return
        case "+/-":
            if(isLeft){
                input_left *= -1
                display_label.text = display(display_num: input_left)
            }else{
                input_right *= -1
                display_label.text = display(display_num: input_right)
            }
            return
        case ".":
            isInteger = false
            return
        case "=":
            calc()
            display_label.text = display(display_num: result)
            return
        case "%":
            if(isLeft){
                input_left *= 0.01
                display_label.text = display(display_num: input_left)
            }else{
                input_right *= 0.01
                display_label.text = display(display_num: input_right)
            }
            return
        default:
            break
        }
    }
    
    private func display(display_num:Double)->String{
        if(display_num.truncatingRemainder(dividingBy: 1) == 0){
            print("display int : \(Int(display_num))")
            return "\(Int(display_num))"
        }else{
            print("display double : \(display_num)")
            return "\(display_num)"
        }
    }
}

