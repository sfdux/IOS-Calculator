//Test go to ResultViewController
require('ResultViewController');
defineClass('MainViewController', {
            clickEqual: function() {
            var resultVC = ResultViewController.new();
            resultVC.setQueryContext(self.textViewScreen().text());
            self.navigationController().pushViewController_animated(resultVC, true);
            },
            });