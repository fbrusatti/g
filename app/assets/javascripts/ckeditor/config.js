CKEDITOR.editorConfig = function( config ) {
    config.language = 'es';
    config.height = '100%';

    config.toolbar = [
      { name: 'document',    items : [ 'Save','NewPage','DocProps','Preview','Print'] },
      { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
      { name: 'editing',     items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
      { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
      { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
      { name: 'insert',      items : [ 'Image','sTable','HorizontalRule','SpecialChar','PageBreak' ] },
      '/',
      { name: 'styles',      items : [ 'Styles','Format','Font','FontSize' ] },
      { name: 'colors',      items : [ 'TextColor','BGColor' ] },
      { name: 'tools',       items : [ 'Maximize', 'ShowBlocks','-','About' ] }
    ];
    config.allowedContent = true;
};
