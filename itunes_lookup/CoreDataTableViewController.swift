//
//  CoreDataTableVC.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 7/3/17.
//  Copyright © 2017 Michael Nienaber. All rights reserved.
//

import UIKit
import CoreData

// MARK: - CoreDataTableViewController: UITableViewController

class CoreDataTableViewController: UITableViewController {

  // MARK: Properties

  var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
    didSet {
      // Whenever the frc changes, we execute the search and
      // reload the table
      fetchedResultsController?.delegate = self
      executeSearch()
      tableView.reloadData()
      print("coredatatableview")
    }
  }

  // MARK: Initializers

  init(fetchedResultsController fc: NSFetchedResultsController<NSFetchRequestResult>, style: UITableViewStyle = .plain) {
    fetchedResultsController = fc
    super.init(style: style)
  }

  // Do not worry about this initializer. I has to be implemented
  // because of the way Swift interfaces with an Objective C
  // protocol called NSArchiving. It's not relevant.
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: - CoreDataTableViewController (For Subclasses)

extension CoreDataTableViewController {

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    fatalError("This method MUST be implemented by a subclass of CoreDataTableViewController")
  }
}

// MARK: - CoreDataTableViewController (UITableViewDataSource)

extension CoreDataTableViewController {

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if let fc = fetchedResultsController {
      return (fc.sections?.count)!
    } else {
      return 0
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let fc = fetchedResultsController {
      return fc.sections![section].numberOfObjects
    } else {
      return 0
    }
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let fc = fetchedResultsController {
      return fc.sections![section].name
    } else {
      return nil
    }
  }

  override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    if let fc = fetchedResultsController {
      return fc.section(forSectionIndexTitle: title, at: index)
    } else {
      return 0
    }
  }

  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    if let fc = fetchedResultsController {
      return fc.sectionIndexTitles
    } else {
      return nil
    }
  }
}

// MARK: - CoreDataTableViewController (Fetches)

extension CoreDataTableViewController {

  func executeSearch() {
    if let fc = fetchedResultsController {
      do {
        try fc.performFetch()
      } catch let e as NSError {
        print("Error while trying to perform a search: \n\(e)\n\(String(describing: fetchedResultsController))")
      }
    }
  }
}

// MARK: - CoreDataTableViewController: NSFetchedResultsControllerDelegate

extension CoreDataTableViewController: NSFetchedResultsControllerDelegate{

  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }

  func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {

    let set = NSIndexSet(index: sectionIndex)

    switch (type) {
    case .insert:
      tableView.insertSections(set as IndexSet, with: .fade)
    case .delete:
      tableView.deleteSections(set as IndexSet, with: .fade)
    default:
      // irrelevant in our case
      break
    }
  }


  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,at indexPath: IndexPath?, for type: NSFetchedResultsChangeType,newIndexPath: IndexPath?) {

    switch(type) {

    case .insert:
      tableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
    case .delete:
      tableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
    case .update:
      tableView.reloadRows(at: [indexPath! as IndexPath], with: .fade)
    case .move:
      tableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
      tableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
    }
  }

  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
}
