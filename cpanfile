requires 'autodie';
requires 'AnyEvent::HTTP';
requires 'File::Copy::Recursive';
requires 'Spreadsheet::ParseExcel';
requires 'Spreadsheet::WriteExcel';
requires 'HTML::Element', '>= 5.00';
requires 'HTML::TreeBuilder::XPath';
requires 'HTML::Selector::XPath';
requires 'Time::HiRes';
requires 'IPC::Run';

on 'test' => sub {
    requires 'Test::More';
    requires 'Test::Deep';
}
