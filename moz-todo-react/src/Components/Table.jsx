import '../App.css'
import { nanoid } from 'nanoid'

function TableComponent(props) {
    const tableCols = props.tableCol.map((col) => <th key={nanoid()}>{col}</th>)
    const tableRows = props.tableRow.map((data) => <tr key={nanoid()}  onClick={() => props.setQuestionId(data[0])}>
        {data.slice(props.startIndex).map((rowData) => <td key={nanoid()}>{rowData}</td>)}</tr>)
    return (
    <table>
        <thead>
            <tr key={nanoid()}>
                {tableCols}
            </tr>
        </thead>
        <tbody>
            {tableRows}
        </tbody>
        
    </table>
    );
}

export default TableComponent