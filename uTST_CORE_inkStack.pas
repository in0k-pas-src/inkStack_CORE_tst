unit uTST_CORE_inkStack;
(*$define testCase -- пометка для gitExtensions-Statickics что это файл ТЕСТ
  [Test
*)
{$mode objfpc}{$H+}
interface

uses fpcunit, inkStack_node;

const
 cTestSuitePath__inkStack='ink Stack';


type

  {[Type TeST Core Test Case] узел списка над которым издеваемся}
 tTST_inkStact_DATA=NativeInt;
 pTST_inkStact_DATA=^tTST_inkStact_DATA;

  {[Type TeST Core Test Case] САМ РОДОначальник тестов}
 tTSTCTC_CORE_inkStack=class(TTestCase)
  protected
    procedure _node_DST(Node:pInkNodeStack);
    function  _node_CRT(Nmbr:NativeUint; const next:pointer):pInkNodeStack;
  protected
    STACK:pointer; //< испытуемое
  protected
    function  _stack_Create  (const Count:NativeInt;  out last:pInkNodeStack):pInkNodeStack; virtual; abstract;
    procedure _stack_DESTROY (var   stck:pInkNodeStack);                                     virtual; abstract;
    function  _stack_clcCount(const stck:pInkNodeStack; out last:pInkNodeStack):NativeUint;  virtual; abstract;
    function  _stack_getFirst(const stck:pInkNodeStack):pInkNodeStack;                       virtual; abstract;
    function  _stack_getNode (const stck:pInkNodeStack; index:NativeUint):pInkNodeStack;     virtual; abstract;
    function  _stack_getLast (const stck:pInkNodeStack):pInkNodeStack;                       virtual; abstract;
  protected
    procedure SetUp;    override;
    procedure TearDown; override;
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    function  TST_node_Create (const obj:pointer; const next:pointer):pointer;// const Nmbr:NativeUint):pointer;
    function  TST_node_Create (const Nmbr:NativeUint):pointer;
    procedure TST_node_DESTROY(const Node:pointer);
    function  TST_node_Nmbr   (const Node:pointer):NativeUint;
    function  TST_DATA_Nmbr   (const DATA:pointer):NativeUint;
    function  TST_node_Next   (const Node:pointer):pointer;
    function  TST_node_DATA   (const Node:pointer):pointer;
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    function  TST_data_Create (const Nmbr:NativeUint):pointer;
    procedure TST_data_DESTROY(const DATA:pointer);
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    function  TST_stack_Create (const Count:NativeUint; out Last:pointer):pointer;overload;
    function  TST_stack_Create (const Count:NativeUint):pointer;                  overload;
    procedure TST_stack_DESTROY(var  aStack:pointer);                             overload;
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    function  TST_STACK_Count:NativeUint;
    function  TST_STACK_LAST :pointer;
    function  TST_STACK_getNODE(index:NativeUint):pointer;
  PUBLIC //< этим можно пользоваться при ТЕСТАХ
    //procedure TST_STACK_Create (const Count:NativeUint; out Last:pointer);        overload;
    //procedure TST_STACK_Create (const Count:NativeUint);                          overload;
  end;


procedure TSTCTC_inkStactDATA_DESTROY(const DATA:pointer);
function  TSTCTC_inkStactDATA_create (const Value:tTST_inkStact_DATA):pTST_inkStact_DATA;


procedure TSTCTC_inkStactNode_DESTROY(const Node:pointer);
function  TSTCTC_inkStactNode_create (const obj :pointer; const next:pointer):pInkNodeStack;       overload;
function  TSTCTC_inkStactNode_create (const Value:tTST_inkStact_DATA; const next:pointer):pInkNodeStack; overload;

implementation

procedure TSTCTC_inkStactDATA_DESTROY(const DATA:pointer);
begin
    dispose(pTST_inkStact_DATA(DATA));
end;

function TSTCTC_inkStactDATA_create(const Value:tTST_inkStact_DATA):pTST_inkStact_DATA;
begin
    new(pTST_inkStact_DATA(result));
    pTST_inkStact_DATA(result)^:=value;
end;


procedure TSTCTC_inkStactNode_DESTROY(const Node:pointer);
begin
    if pInkNodeStack(Node)^.DATA<>nil then begin
        TSTCTC_inkStactDATA_DESTROY(pInkNodeStack(Node)^.DATA);
    end;
    InkNodeStack_Destroy(pInkNodeStack(Node))
end;

function TSTCTC_inkStactNode_create (const obj :pointer; const next:pointer):pInkNodeStack;
begin
    result:=InkNodeStack_Create(obj,next);
end;

function  TSTCTC_inkStactNode_create(const Value:tTST_inkStact_DATA; const next:pointer):pInkNodeStack;
begin
    result:=InkNodeStack_Create(TSTCTC_inkStactDATA_create(value), next);
end;

//==============================================================================

procedure tTSTCTC_CORE_inkStack.SetUp;
begin
    STACK:=NIL;
end;

procedure tTSTCTC_CORE_inkStack.TearDown;
begin
    if STACK<>nil then _stack_DESTROY(pInkNodeStack(STACK));
end;

//------------------------------------------------------------------------------

procedure tTSTCTC_CORE_inkStack._node_DST(Node:pInkNodeStack);
begin
    TSTCTC_inkStactNode_DESTROY(node)
end;

function tTSTCTC_CORE_inkStack._node_CRT(Nmbr:NativeUint; const next:pointer):pInkNodeStack;
begin
    result:=TSTCTC_inkStactNode_create(Nmbr,next)
end;

//------------------------------------------------------------------------------

function tTSTCTC_CORE_inkStack.TST_data_Create(const Nmbr:NativeUint):pointer;
begin
    new(pTST_inkStact_DATA(result));
    pTST_inkStact_DATA(result)^:=Nmbr;
end;

procedure tTSTCTC_CORE_inkStack.TST_data_DESTROY(const DATA:pointer);
begin
    TSTCTC_inkStactDATA_DESTROY(DATA)
end;

//------------------------------------------------------------------------------

function  tTSTCTC_CORE_inkStack.TST_node_Create(const obj:pointer; const next:pointer):pointer;
begin
    result:=TSTCTC_inkStactNode_create(obj,next);
end;

function tTSTCTC_CORE_inkStack.TST_node_Create(const Nmbr:NativeUint):pointer;
begin
    result:=TSTCTC_inkStactNode_create(Nmbr,nil);
end;

procedure tTSTCTC_CORE_inkStack.TST_node_DESTROY(const Node:pointer);
begin
    _node_DST(Node);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const cTST_node_NotNmbr=1000000;//max(NativeUint);
function tTSTCTC_CORE_inkStack.TST_node_Nmbr(const Node:pointer):NativeUint;
begin
    result:=cTST_node_NotNmbr;
    if pInkNodeStack(node)^.DATA<>nil then begin
        result:=pTST_inkStact_DATA(pInkNodeStack(node)^.DATA)^;
    end;
end;

function tTSTCTC_CORE_inkStack.TST_DATA_Nmbr(const DATA:pointer):NativeUint;
begin
    result:=cTST_node_NotNmbr;
    if DATA<>nil then begin
        result:=pTST_inkStact_DATA(DATA)^;
    end;
end;

function tTSTCTC_CORE_inkStack.TST_node_Next(const Node:pointer):pointer;
begin
    result:=pInkNodeStack(node)^.next;
end;

function tTSTCTC_CORE_inkStack.TST_node_DATA(const Node:pointer):pointer;
begin
    result:=pInkNodeStack(node)^.DATA;
end;

//------------------------------------------------------------------------------

function tTSTCTC_CORE_inkStack.TST_stack_Create(const Count:NativeUint; out Last:pointer):pointer;
begin
    result:=_stack_Create(Count,Last);
end;

function tTSTCTC_CORE_inkStack.TST_stack_Create(const Count:NativeUint):pointer;
var Last:pointer;
begin
    result:=_stack_Create(Count,Last);
end;

procedure tTSTCTC_CORE_inkStack.TST_stack_DESTROY(var aStack:pointer);
begin
    _stack_DESTROY(aStack);
end;

//------------------------------------------------------------------------------

function tTSTCTC_CORE_inkStack.TST_STACK_Count:NativeUint;
var last:pointer;
begin
    result:=_stack_clcCount(STACK,last);
end;

function tTSTCTC_CORE_inkStack.TST_STACK_LAST:pointer;
begin
    result:=_stack_getLast(STACK);
end;

function tTSTCTC_CORE_inkStack.TST_STACK_getNODE(index:NativeUint):pointer;
begin
    result:=_stack_getNode(STACK,index);
end;

//------------------------------------------------------------------------------

{procedure tTSTCTC_CORE_inkStack.TST_STACK_Create(const Count:NativeUint; out Last:pointer);
begin
    if STACK<>nil then _stack_DESTROY(STACK);
    STACK:=nil;
    //---
    STACK:=_stack_Create(Count,Last);
end;}

{procedure tTSTCTC_CORE_inkStack.TST_STACK_Create(const Count:NativeUint);
var last:pointer;
begin
    if STACK<>nil then _stack_DESTROY(STACK);
    STACK:=nil;
    //---
    STACK:=_stack_Create(Count,Last);
end;}

end.
