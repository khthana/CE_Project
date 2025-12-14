MD   c:\SSHIsagTerm
MD   c:\SSHIsagTerm\IsagTerm
COPY a:\IsagTerm\*.* c:\SSHIsagTerm\IsagTerm
MD   c:\SSHIsagTerm\Uninstall  
COPY a:\Uninstall\*.* c:\SSHIsagTerm\Uninstall

CD   c:\SSHIsagTerm\IsagTerm
MD   c:\SSHIsagTerm\IsagTerm\SSH
MD   c:\SSHIsagTerm\IsagTerm\TERMINAL
MD   c:\SSHIsagTerm\IsagTerm\Utility   
COPY a:\IsagTerm\SSH\*.* c:\SSHIsagTerm\IsagTerm\SSH  
COPY a:\IsagTerm\TERMINAL\*.* c:\SSHIsagTerm\IsagTerm\TERMINAL   
COPY a:\IsagTerm\Utility\*.* c:\SSHIsagTerm\IsagTerm\Utility
CD   c:\SSHIsagTerm\IsagTerm

@echo 
@echo     ****************************************************************
@echo     *                     Install complete                         *
@echo     *                                                              *
@echo     * Execute files = c:\SSHIsgaTerm\IsagTerm\IsagTerm.EXE         *
@echo     *                                                              *
@echo     ****************************************************************
 
