FROM gitpod/workspace-full
                    
USER gitpod

RUN echo "should fail" && false
